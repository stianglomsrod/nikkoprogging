import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class IdleStateView extends StatelessWidget {
  const IdleStateView({super.key, required this.onSimulate});

  final VoidCallback onSimulate;

  @override
  Widget build(BuildContext context) {
    return BottomActionGroup(
      groupKey: const ValueKey('actions-idle'),
      children: [
        FilledButton(
          onPressed: onSimulate,
          child: const Text('Simuler neste prompt'),
        ),
      ],
    );
  }
}
