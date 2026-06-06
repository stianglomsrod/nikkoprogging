import 'package:companion_app/core/events/companion_identity.dart';
import 'package:flutter/material.dart';

class BackgroundToneSettingsPanel extends StatelessWidget {
  const BackgroundToneSettingsPanel({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final CompanionBackgroundTone selected;
  final ValueChanged<CompanionBackgroundTone> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bakgrunnsfarge',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Velg en rolig bakgrunnstone.'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in CompanionBackgroundTone.values)
                  ChoiceChip(
                    key: ValueKey('settings-background-option-${option.name}'),
                    label: Text(option.label),
                    selected: selected == option,
                    onSelected: (_) => onChanged(option),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
