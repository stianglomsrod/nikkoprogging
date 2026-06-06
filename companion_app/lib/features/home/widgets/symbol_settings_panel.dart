import 'package:companion_app/core/events/companion_identity.dart';
import 'package:flutter/material.dart';

class SymbolSettingsPanel extends StatelessWidget {
  const SymbolSettingsPanel({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final CompanionSymbolOption selected;
  final ValueChanged<CompanionSymbolOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Symbol', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Velg et lite symbol for companion-navnet.'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in CompanionSymbolOption.values)
                  ChoiceChip(
                    key: ValueKey('settings-symbol-option-${option.name}'),
                    label: Text(
                      option.glyph == null
                          ? option.label
                          : '${option.label} ${option.glyph}',
                    ),
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
