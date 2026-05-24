import 'dart:math';

import 'package:companion_app/core/adaptive_engine/task_selector.dart';
import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/focus_area.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/core/models/task_item.dart';
import 'package:companion_app/core/scheduler/scheduler_engine.dart';
import 'package:companion_app/core/seed_data/seed_data.dart';
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
            'Ingen Fokusomrader er klare akkurat na. Du kan justere rammene i Innstillinger.';
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
      const messages = [
        'Fint. Det var et lite steg, og det teller.',
        'Bra gjort. Ett steg er nok.',
      ];
      return messages[_random.nextInt(messages.length)];
    }

    const messages = [
      'Helt greit. Vi prover noe annet neste gang.',
      'Det gar fint. Oppgaven var kanskje ikke riktig akkurat na.',
    ];
    return messages[_random.nextInt(messages.length)];
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
    final result = await Navigator.of(context).push<_SettingsResult>(
      MaterialPageRoute(
        builder: (_) => _SettingsPage(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _CompanionFigure(),
              const SizedBox(height: 12),
              Text(
                'Jeg gir deg bare en liten ting av gangen.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Nar det passer innenfor rammene dine, kan jeg foresla et lite steg.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Expanded(child: _buildMainCard(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          const Text('Klar nar du er.', textAlign: TextAlign.center),
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
          const Spacer(),
        ],
      );
    }

    if (_stage == PromptStage.mood) {
      return Column(
        key: const ValueKey('mood'),
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Et lite steg', textAlign: TextAlign.center),
        const SizedBox(height: 8),
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Text(_resultMessage ?? '', textAlign: TextAlign.center),
        const SizedBox(height: 12),
        FilledButton.tonal(
          onPressed: _resetToIdle,
          child: const Text('Tilbake til rolig visning'),
        ),
        const Spacer(),
      ],
    );
  }
}

class _CompanionFigure extends StatelessWidget {
  const _CompanionFigure();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.primaryContainer,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 35,
              left: 40,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: colors.onPrimaryContainer,
              ),
            ),
            Positioned(
              top: 35,
              right: 40,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: colors.onPrimaryContainer,
              ),
            ),
            Positioned(
              bottom: 36,
              child: Container(
                width: 34,
                height: 14,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colors.onPrimaryContainer,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsResult {
  const _SettingsResult({
    required this.focusAreas,
    required this.simulatedHour,
  });

  final List<FocusArea> focusAreas;
  final int simulatedHour;
}

class _SettingsPage extends StatefulWidget {
  const _SettingsPage({required this.focusAreas, required this.simulatedHour});

  final List<FocusArea> focusAreas;
  final int simulatedHour;

  @override
  State<_SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<_SettingsPage> {
  late List<FocusArea> _localFocusAreas;
  late int _localHour;

  @override
  void initState() {
    super.initState();
    _localFocusAreas = widget.focusAreas
        .map(
          (area) => area.copyWith(
            enabled: area.enabled,
            startHour: area.startHour,
            endHour: area.endHour,
            modus: area.modus,
          ),
        )
        .toList(growable: true);
    _localHour = widget.simulatedHour;
  }

  void _saveAndClose() {
    Navigator.of(context).pop(
      _SettingsResult(focusAreas: _localFocusAreas, simulatedHour: _localHour),
    );
  }

  void _updateArea(String areaId, FocusArea Function(FocusArea area) updater) {
    setState(() {
      _localFocusAreas = _localFocusAreas
          .map((area) => area.id == areaId ? updater(area) : area)
          .toList(growable: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Innstillinger'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton(onPressed: _saveAndClose, child: const Text('Lagre')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Fokusomrader'),
          const SizedBox(height: 8),
          for (final area in _localFocusAreas) ...[
            _FocusAreaTile(
              area: area,
              onEnabledChanged: (value) {
                _updateArea(area.id, (a) => a.copyWith(enabled: value));
              },
              onStartChanged: (value) {
                _updateArea(area.id, (a) => a.copyWith(startHour: value));
              },
              onEndChanged: (value) {
                _updateArea(area.id, (a) => a.copyWith(endHour: value));
              },
              onModusChanged: (value) {
                _updateArea(area.id, (a) => a.copyWith(modus: value));
              },
            ),
            const Divider(height: 24),
          ],
          const SizedBox(height: 8),
          const Text('Simulert tid for prototype'),
          const SizedBox(height: 8),
          Text(_hourLabel(_localHour)),
          Slider(
            value: _localHour.toDouble(),
            min: 0,
            max: 23,
            divisions: 23,
            label: _hourLabel(_localHour),
            onChanged: (value) {
              setState(() {
                _localHour = value.round();
              });
            },
          ),
        ],
      ),
    );
  }

  String _hourLabel(int hour) => '${hour.toString().padLeft(2, '0')}:00';
}

class _FocusAreaTile extends StatelessWidget {
  const _FocusAreaTile({
    required this.area,
    required this.onEnabledChanged,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onModusChanged,
  });

  final FocusArea area;
  final ValueChanged<bool> onEnabledChanged;
  final ValueChanged<int> onStartChanged;
  final ValueChanged<int> onEndChanged;
  final ValueChanged<Modus> onModusChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                area.name,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Switch(value: area.enabled, onChanged: onEnabledChanged),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: area.startHour,
                decoration: const InputDecoration(
                  labelText: 'Aktivt tidsrom fra',
                ),
                items: [
                  for (int hour = 0; hour < 24; hour++)
                    DropdownMenuItem(
                      value: hour,
                      child: Text(_labelHour(hour)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onStartChanged(value);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: area.endHour,
                decoration: const InputDecoration(
                  labelText: 'Aktivt tidsrom til',
                ),
                items: [
                  for (int hour = 0; hour < 24; hour++)
                    DropdownMenuItem(
                      value: hour,
                      child: Text(_labelHour(hour)),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onEndChanged(value);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Modus>(
          initialValue: area.modus,
          decoration: const InputDecoration(labelText: 'Modus'),
          items: [
            for (final mode in Modus.values)
              DropdownMenuItem(
                value: mode,
                child: Text('${mode.label} (${mode.maxPrompts})'),
              ),
          ],
          onChanged: (value) {
            if (value != null) {
              onModusChanged(value);
            }
          },
        ),
      ],
    );
  }

  String _labelHour(int hour) => '${hour.toString().padLeft(2, '0')}:00';
}
