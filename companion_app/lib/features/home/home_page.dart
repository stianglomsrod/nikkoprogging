import 'dart:async';
import 'dart:math';

import 'package:companion_app/core/content/companion_text_library.dart';
import 'package:companion_app/core/adaptive_engine/task_selector.dart';
import 'package:companion_app/core/flow/energisk_chain_controller.dart';
import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/core/models/task_item.dart';
import 'package:companion_app/core/scheduler/scheduler_engine.dart';
import 'package:companion_app/core/seed_data/seed_data.dart';
import 'package:companion_app/features/home/settings_page.dart';
import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:companion_app/features/home/widgets/companion_figure.dart';
import 'package:companion_app/features/home/widgets/dialogue_box.dart';
import 'package:companion_app/features/home/widgets/home_layout_shell.dart';
import 'package:companion_app/features/home/widgets/idle_state_view.dart';
import 'package:companion_app/features/home/widgets/mood_state_view.dart';
import 'package:companion_app/features/home/widgets/result_state_view.dart';
import 'package:companion_app/features/home/widgets/task_state_view.dart';
import 'package:flutter/material.dart';

enum PromptStage { idle, mood, task, result }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Duration _happyAnimationDuration = Duration(milliseconds: 2200);

  final SchedulerEngine _scheduler = SchedulerEngine();
  final TaskSelector _selector = TaskSelector();
  final EnergiskChainController _energiskChain = EnergiskChainController();
  final Random _random = Random();

  late List<FocusArea> _focusAreas;
  late final List<TaskItem> _allTasks;

  final Map<String, int> _promptsUsedPerArea = <String, int>{};
  final List<AttemptEntry> _attemptHistory = <AttemptEntry>[];
  final List<String> _recentFailedTaskIds = <String>[];

  int _simulatedHour = 18;
  PromptStage _stage = PromptStage.idle;

  FocusArea? _activeFocusArea;
  Sinnsstemning? _currentMood;
  TaskItem? _currentTask;
  String? _statusMessage;
  String? _resultMessage;
  CompanionAnimationState _companionAnimationState =
      CompanionAnimationState.idle;
  Timer? _happyResetTimer;

  @override
  void initState() {
    super.initState();
    _focusAreas = SeedData.focusAreas();
    _allTasks = SeedData.tasks();
  }

  @override
  void dispose() {
    _happyResetTimer?.cancel();
    super.dispose();
  }

  void _simulateNextPrompt() {
    setState(() {
      _statusMessage = null;
      _resultMessage = null;

      final area = _scheduler.selectEligibleFocusArea(
        focusAreas: _focusAreas,
        promptsUsed: _promptsUsedPerArea,
        currentHour: _simulatedHour,
      );

      if (area == null) {
        _stage = PromptStage.idle;
        _activeFocusArea = null;
        _currentMood = null;
        _currentTask = null;
        _statusMessage =
            'Hei. Fint å se deg. Jeg har ingen oppgaver til deg akkurat nå.';
        _setCompanionToDefaultAnimation();
        return;
      }

      _activeFocusArea = area;
      _promptsUsedPerArea[area.id] = (_promptsUsedPerArea[area.id] ?? 0) + 1;
      _currentMood = null;
      _currentTask = null;
      _stage = PromptStage.mood;
      _statusMessage = null;
      _setCompanionToDefaultAnimation();
    });
  }

  void _selectMood(Sinnsstemning mood) {
    final area = _activeFocusArea;
    if (area == null) {
      return;
    }

    _energiskChain.onMoodSelected(mood);
    final shouldStartChain = _energiskChain.shouldStartChain;
    final task = _selectTask(
      focusAreaId: area.id,
      mood: mood,
      blockedTaskIds: const <String>[],
    );

    setState(() {
      if (shouldStartChain && task != null) {
        _energiskChain.activateChainWithFirstTask(task.id);
      } else if (shouldStartChain && task == null) {
        _energiskChain.completeChainCycle();
      } else {
        _energiskChain.deactivateChain();
      }

      _currentMood = mood;
      _currentTask = task;
      _stage = PromptStage.task;
      _setCompanionToDefaultAnimation();
      if (task == null) {
        _statusMessage = 'Fant ingen oppgave for ${area.name} akkurat nå.';
      }
    });
  }

  void _submitResult(bool done) {
    final area = _activeFocusArea;
    final mood = _currentMood;
    final task = _currentTask;
    if (area == null || mood == null || task == null) {
      return;
    }

    setState(() {
      _attemptHistory.add(
        AttemptEntry(
          taskId: task.id,
          focusAreaId: area.id,
          done: done,
          mood: mood,
          timestamp: DateTime.now(),
        ),
      );

      if (done) {
        _recentFailedTaskIds.remove(task.id);
      } else {
        _recentFailedTaskIds.remove(task.id);
        _recentFailedTaskIds.insert(0, task.id);
        if (_recentFailedTaskIds.length > 5) {
          _recentFailedTaskIds.removeLast();
        }
      }

      if (_energiskChain.shouldSkipMoodPrompt) {
        final nextTask = _selectTask(
          focusAreaId: area.id,
          mood: Sinnsstemning.energisk,
          blockedTaskIds: _energiskChain.usedTaskIds,
        );

        if (nextTask != null) {
          _currentTask = nextTask;
          _currentMood = Sinnsstemning.energisk;
          _energiskChain.markFollowUpTaskStarted(nextTask.id);
          _stage = PromptStage.task;
          _setCompanionToDefaultAnimation();
          return;
        }

        _energiskChain.completeChainCycle();
      }

      if (_energiskChain.isChainActive &&
          !_energiskChain.hasPendingFollowUpTask) {
        _energiskChain.completeChainCycle();
      }

      _resultMessage = _pickResultMessage(done);
      _stage = PromptStage.result;
      if (done) {
        _triggerHappyAnimation();
      } else {
        _setCompanionToDefaultAnimation();
      }
    });
  }

  bool _shouldShowSleepAnimation() {
    return _stage == PromptStage.idle && _statusMessage != null;
  }

  CompanionAnimationState _defaultAnimationForState() {
    return _shouldShowSleepAnimation()
        ? CompanionAnimationState.sleep
        : CompanionAnimationState.idle;
  }

  void _setCompanionToDefaultAnimation() {
    _happyResetTimer?.cancel();
    _companionAnimationState = _defaultAnimationForState();
  }

  void _triggerHappyAnimation() {
    _happyResetTimer?.cancel();
    _companionAnimationState = CompanionAnimationState.happy;
    _happyResetTimer = Timer(_happyAnimationDuration, () {
      if (!mounted) {
        return;
      }
      setState(() {
        if (_companionAnimationState == CompanionAnimationState.happy) {
          _companionAnimationState = _defaultAnimationForState();
        }
      });
    });
  }

  TaskItem? _selectTask({
    required String focusAreaId,
    required Sinnsstemning mood,
    required List<String> blockedTaskIds,
  }) {
    final excluded = <String>{
      ..._recentFailedTaskIds,
      ...blockedTaskIds,
    }.toList(growable: false);

    return _selector.selectTask(
      focusAreaId: focusAreaId,
      mood: mood,
      allTasks: _allTasks,
      history: _attemptHistory,
      recentFailedTaskIds: excluded,
    );
  }

  String _pickResultMessage(bool done) {
    if (done) {
      final mood = _currentMood ?? Sinnsstemning.ok;
      return _pickFrom(
        CompanionTextLibrary.taskDoneYes[CompanionTextLibrary.moodKey(mood)]!,
      );
    }
    return _pickFrom(CompanionTextLibrary.taskDoneNo);
  }

  void _resetToIdle() {
    setState(() {
      _stage = PromptStage.idle;
      _activeFocusArea = null;
      _currentMood = null;
      _currentTask = null;
      _statusMessage = null;
      _resultMessage = null;
      _setCompanionToDefaultAnimation();
    });
  }

  Future<void> _openSettings() async {
    final result = await Navigator.of(context).push<SettingsResult>(
      MaterialPageRoute(
        builder: (_) => SettingsPage(
          focusAreas: _focusAreas,
          simulatedHour: _simulatedHour,
        ),
      ),
    );

    if (result == null) {
      return;
    }

    setState(() {
      _focusAreas = result.focusAreas;
      _simulatedHour = result.simulatedHour;
    });
  }

  String _moodLabel(Sinnsstemning mood) {
    switch (mood) {
      case Sinnsstemning.negativ:
        return 'Tung';
      case Sinnsstemning.ok:
        return 'Ok';
      case Sinnsstemning.energisk:
        return 'Energisk';
    }
  }

  String _pickFrom(List<String> values) {
    return values[_random.nextInt(values.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('.....'),
        actions: [
          IconButton(
            onPressed: _openSettings,
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Innstillinger',
          ),
        ],
      ),
      body: HomeLayoutShell(
        dialogue: DialogueBox(text: _dialogueLines().join(' ')),
        figure: _stage == PromptStage.result
            ? GestureDetector(
                onTap: _resetToIdle,
                behavior: HitTestBehavior.translucent,
                child: CompanionFigure(
                  animationState: _companionAnimationState,
                ),
              )
            : CompanionFigure(animationState: _companionAnimationState),
        bottomActions: BottomActionArea(child: _buildBottomActionState()),
      ),
    );
  }

  List<String> _dialogueLines() {
    if (_stage == PromptStage.idle) {
      return [
        if (_statusMessage != null)
          _statusMessage!
        else
          'Hei. Hvordan er formen din akkurat nå?',
      ];
    }

    if (_stage == PromptStage.mood) {
      return ['Hei. Hvordan kjennes det akkurat nå?'];
    }

    if (_stage == PromptStage.task) {
      final task = _currentTask;
      if (task == null) {
        return [
          'Jeg finner ingen oppgave akkurat nå. Vi kan prøve igjen snart.',
        ];
      }

      return [task.title];
    }

    return [_resultMessage ?? 'Helt greit.'];
  }

  Widget _buildBottomActionState() {
    if (_stage == PromptStage.idle) {
      return IdleStateView(onSimulate: _simulateNextPrompt);
    }

    if (_stage == PromptStage.mood) {
      return MoodStateView(onSelectMood: _selectMood, labelBuilder: _moodLabel);
    }

    if (_stage == PromptStage.task) {
      return TaskStateView(
        hasTask: _currentTask != null,
        onDone: () => _submitResult(true),
        onSkipped: () => _submitResult(false),
        onBack: _resetToIdle,
      );
    }

    return ResultStateView(onBack: _resetToIdle);
  }
}
