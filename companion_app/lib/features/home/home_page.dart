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
            'Ingen fokusomrader er klare akkurat na. Juster Aktivt tidsrom eller Modus.';
        return;
      }

      _activeFocusArea = area;
      _promptsUsedPerArea[area.id] = (_promptsUsedPerArea[area.id] ?? 0) + 1;
      _currentMood = null;
      _currentTask = null;
      _stage = PromptStage.mood;
      _statusMessage =
          'Prompt for ${area.name} ved kl ${_hourLabel(_simulatedHour)}.';
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

  void _updateArea(String areaId, FocusArea Function(FocusArea area) updater) {
    setState(() {
      _focusAreas = _focusAreas
          .map((area) => area.id == areaId ? updater(area) : area)
          .toList(growable: false);
    });
  }

  double get _successRate {
    if (_attemptHistory.isEmpty) {
      return 0;
    }
    final doneCount = _attemptHistory.where((entry) => entry.done).length;
    return doneCount / _attemptHistory.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rolig Companion Prototype')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'En rolig hjelp gjennom dagen. En Oppgave av gangen.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildOverviewCard(context),
            const SizedBox(height: 16),
            _buildFocusAreaCard(),
            const SizedBox(height: 16),
            _buildSchedulerCard(),
            const SizedBox(height: 16),
            _buildPromptFlowCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Text('Forsok: ${_attemptHistory.length}'),
            Text('Suksessrate: ${(_successRate * 100).toStringAsFixed(0)} %'),
            if (_statusMessage != null) ...[
              const SizedBox(height: 8),
              Text(_statusMessage!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFocusAreaCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Fokusomrader'),
            const SizedBox(height: 8),
            for (final area in _focusAreas) ...[
              _FocusAreaTile(
                area: area,
                promptsUsed: _promptsUsedPerArea[area.id] ?? 0,
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
          ],
        ),
      ),
    );
  }

  Widget _buildSchedulerCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Simulert scheduler'),
            const SizedBox(height: 8),
            Text('Simulert klokkeslett: ${_hourLabel(_simulatedHour)}'),
            Slider(
              value: _simulatedHour.toDouble(),
              min: 0,
              max: 23,
              divisions: 23,
              label: _hourLabel(_simulatedHour),
              onChanged: (value) {
                setState(() {
                  _simulatedHour = value.round();
                });
              },
            ),
            ElevatedButton(
              onPressed: _simulateNextPrompt,
              child: const Text('Simuler neste prompt'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptFlowCard(BuildContext context) {
    final activeArea = _activeFocusArea;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Promptflyt', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            if (activeArea != null)
              Text('Aktivt Fokusomrade: ${activeArea.name}'),
            if (_stage == PromptStage.idle)
              const Text(
                'Trykk "Simuler neste prompt" nar appen skal foresla en Oppgave.',
              ),
            if (_stage == PromptStage.mood) _buildMoodStep(),
            if (_stage == PromptStage.task) _buildTaskStep(),
            if (_stage == PromptStage.result) _buildResultStep(),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hvordan er stemningen akkurat na?'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            for (final mood in Sinnsstemning.values)
              OutlinedButton(
                onPressed: () => _selectMood(mood),
                child: Text(mood.label),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaskStep() {
    final task = _currentTask;
    if (task == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ingen Oppgave funnet akkurat na.'),
          const SizedBox(height: 8),
          TextButton(onPressed: _resetToIdle, child: const Text('Tilbake')),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Oppgave: ${task.title}'),
        const SizedBox(height: 8),
        const Text('Fikk du gjort oppgaven?'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            FilledButton(
              onPressed: () => _submitResult(true),
              child: const Text('Ja'),
            ),
            OutlinedButton(
              onPressed: () => _submitResult(false),
              child: const Text('Nei'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildResultStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_resultMessage ?? ''),
        const SizedBox(height: 8),
        TextButton(
          onPressed: _resetToIdle,
          child: const Text('Klar for neste prompt'),
        ),
      ],
    );
  }

  String _hourLabel(int hour) {
    final text = hour.toString().padLeft(2, '0');
    return '$text:00';
  }
}

class _FocusAreaTile extends StatelessWidget {
  const _FocusAreaTile({
    required this.area,
    required this.promptsUsed,
    required this.onEnabledChanged,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.onModusChanged,
  });

  final FocusArea area;
  final int promptsUsed;
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
        const SizedBox(height: 8),
        Text('Brukt i vindu: $promptsUsed / ${area.modus.maxPrompts}'),
      ],
    );
  }

  String _labelHour(int hour) => '${hour.toString().padLeft(2, '0')}:00';
}
