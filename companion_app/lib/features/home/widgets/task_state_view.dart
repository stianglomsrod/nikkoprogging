import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class TaskStateView extends StatelessWidget {
  const TaskStateView({
    super.key,
    required this.hasTask,
    required this.onDone,
    required this.onSkipped,
    required this.onBack,
  });

  final bool hasTask;
  final VoidCallback onDone;
  final VoidCallback onSkipped;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    if (!hasTask) {
      return BottomActionGroup(
        groupKey: const ValueKey('actions-task-empty'),
        children: [
          FilledButton.tonal(onPressed: onBack, child: const Text('Tilbake')),
        ],
      );
    }

    return BottomActionGroup(
      groupKey: const ValueKey('actions-task'),
      children: [
        Text(
          'Fikk du gjort oppgaven?',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        FilledButton(onPressed: onDone, child: const Text('Ja')),
        const SizedBox(height: 8),
        OutlinedButton(onPressed: onSkipped, child: const Text('Nei')),
      ],
    );
  }
}
