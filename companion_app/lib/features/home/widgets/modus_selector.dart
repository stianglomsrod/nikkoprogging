import 'package:companion_app/core/models/modus.dart';
import 'package:flutter/material.dart';

class ModusSelector extends StatelessWidget {
  const ModusSelector({
    super.key,
    required this.selectedModus,
    required this.onSelected,
  });

  final Modus selectedModus;
  final ValueChanged<Modus> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (final mode in Modus.values)
          ChoiceChip(
            label: Text(mode.label),
            selected: selectedModus == mode,
            onSelected: (_) => onSelected(mode),
          ),
      ],
    );
  }
}
