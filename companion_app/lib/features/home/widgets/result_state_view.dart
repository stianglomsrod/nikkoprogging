import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class ResultStateView extends StatelessWidget {
  const ResultStateView({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return BottomActionGroup(
      groupKey: const ValueKey('actions-result'),
      children: [
        FilledButton.tonal(onPressed: onBack, child: const Text('Fortsett')),
      ],
    );
  }
}
