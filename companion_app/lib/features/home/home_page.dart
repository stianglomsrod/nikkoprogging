import 'dart:math';

import 'package:companion_app/core/content/companion_text_library.dart';
import 'package:companion_app/core/adaptive_engine/task_selector.dart';
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
  final SchedulerEngine _scheduler = SchedulerEngine();
  final TaskSelector _selector = TaskSelector();
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

  @override
  void initState() {
    super.initState();
    _focusAreas = SeedData.focusAreas();
    _allTasks = SeedData.tasks();
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
            'Ingen fokusområder er klare akkurat nå. Du kan justere rammene i Innstillinger.';
        return;
      }

      _activeFocusArea = area;
      _promptsUsedPerArea[area.id] = (_promptsUsedPerArea[area.id] ?? 0) + 1;
      _currentMood = null;
      _currentTask = null;
      _stage = PromptStage.mood;
      _statusMessage = null;
    });
  }

  void _selectMood(Sinnsstemning mood) {
    final area = _activeFocusArea;
    if (area == null) {
      return;
    }

    final task = _selector.selectTask(
      focusAreaId: area.id,
      mood: mood,
      allTasks: _allTasks,
      history: _attemptHistory,
      recentFailedTaskIds: _recentFailedTaskIds,
    );

    setState(() {
      _currentMood = mood;
      _currentTask = task;
      _stage = PromptStage.task;
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

      _resultMessage = _pickResultMessage(done);
      _stage = PromptStage.result;
    });
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
        figure: const CompanionFigure(),
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
