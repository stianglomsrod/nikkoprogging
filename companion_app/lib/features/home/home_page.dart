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
import 'package:companion_app/features/home/widgets/companion_figure.dart';
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
  late String _greetingText;
  late String _introMemoryText;
  String? _taskLeadIn;
  String? _moodSupportText;

  @override
  void initState() {
    super.initState();
    _focusAreas = SeedData.focusAreas();
    _allTasks = SeedData.tasks();
    _greetingText = CompanionTextLibrary.greetings[0];
    _introMemoryText = CompanionTextLibrary.memoryMessages[3];
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
            'Ingen Fokusomrader er klare akkurat na. Du kan justere rammene i Innstillinger.';
        return;
      }

      _activeFocusArea = area;
      _promptsUsedPerArea[area.id] = (_promptsUsedPerArea[area.id] ?? 0) + 1;
      _currentMood = null;
      _currentTask = null;
      _taskLeadIn = null;
      _moodSupportText = null;
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
      _moodSupportText = _pickFrom(
        CompanionTextLibrary.moodFeedback[CompanionTextLibrary.moodKey(mood)]!,
      );
      _taskLeadIn = _pickFrom(CompanionTextLibrary.taskRequestPhrases);
      if (task == null) {
        _statusMessage = 'Fant ingen Oppgave for ${area.name} akkurat na.';
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
      _taskLeadIn = null;
      _moodSupportText = null;
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
        return 'tung';
      case Sinnsstemning.ok:
        return 'ok';
      case Sinnsstemning.energisk:
        return 'energisk';
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _greetingText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _introMemoryText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 22),
                        const CompanionFigure(),
                        const SizedBox(height: 24),
                        _buildMainCard(context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _buildStageContent(context),
        ),
      ),
    );
  }

  Widget _buildStageContent(BuildContext context) {
    final activeArea = _activeFocusArea;

    if (_stage == PromptStage.idle) {
      return Column(
        key: const ValueKey('idle'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Jeg gir deg bare en liten ting av gangen.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (_statusMessage != null)
            Text(_statusMessage!, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _simulateNextPrompt,
            child: const Text('Simuler neste prompt'),
          ),
          const SizedBox(height: 8),
          Text(
            'Dette erstatter varsling i prototypen.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );
    }

    if (_stage == PromptStage.mood) {
      return Column(
        key: const ValueKey('mood'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (activeArea != null)
            Text(
              activeArea.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          const SizedBox(height: 12),
          const Text(
            'Hvordan er stemningen akkurat na?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          for (final mood in Sinnsstemning.values) ...[
            FilledButton.tonal(
              onPressed: () => _selectMood(mood),
              child: Text(_moodLabel(mood)),
            ),
            const SizedBox(height: 8),
          ],
        ],
      );
    }

    if (_stage == PromptStage.task) {
      return _buildTaskStep();
    }

    return _buildResultStep();
  }

  Widget _buildTaskStep() {
    final task = _currentTask;
    if (task == null) {
      return Column(
        key: const ValueKey('task-empty'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Fant ingen Oppgave akkurat na.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          TextButton(onPressed: _resetToIdle, child: const Text('Tilbake')),
        ],
      );
    }

    return Column(
      key: const ValueKey('task'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Et lite steg', textAlign: TextAlign.center),
        const SizedBox(height: 8),
        if (_moodSupportText != null) ...[
          Text(_moodSupportText!, textAlign: TextAlign.center),
          const SizedBox(height: 12),
        ],
        if (_taskLeadIn != null) ...[
          Text(
            _taskLeadIn!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
        ],
        Text(
          task.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        const Text('Fikk du gjort oppgaven?', textAlign: TextAlign.center),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () => _submitResult(true),
          child: const Text('Ja'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () => _submitResult(false),
          child: const Text('Nei'),
        ),
      ],
    );
  }

  Widget _buildResultStep() {
    return Column(
      key: const ValueKey('result'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(_resultMessage ?? '', textAlign: TextAlign.center),
        const SizedBox(height: 12),
        FilledButton.tonal(
          onPressed: _resetToIdle,
          child: const Text('Tilbake'),
        ),
      ],
    );
  }
}
