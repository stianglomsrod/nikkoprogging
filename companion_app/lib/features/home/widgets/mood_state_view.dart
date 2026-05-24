import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class MoodStateView extends StatelessWidget {
  const MoodStateView({
    super.key,
    required this.onSelectMood,
    required this.labelBuilder,
  });

  final ValueChanged<Sinnsstemning> onSelectMood;
  final String Function(Sinnsstemning mood) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return BottomActionGroup(
      groupKey: const ValueKey('actions-mood'),
      children: [
        for (final mood in Sinnsstemning.values) ...[
          FilledButton.tonal(
            onPressed: () => onSelectMood(mood),
            child: Text(labelBuilder(mood)),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
