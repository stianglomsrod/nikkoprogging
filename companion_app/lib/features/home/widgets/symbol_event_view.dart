import 'package:companion_app/core/events/companion_identity.dart';
import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class SymbolEventView extends StatefulWidget {
  const SymbolEventView({
    super.key,
    required this.onSave,
    required this.onSkip,
  });

  final ValueChanged<CompanionSymbolOption> onSave;
  final VoidCallback onSkip;

  @override
  State<SymbolEventView> createState() => _SymbolEventViewState();
}

class _SymbolEventViewState extends State<SymbolEventView> {
  CompanionSymbolOption _selected = CompanionSymbolOption.none;

  @override
  Widget build(BuildContext context) {
    return BottomActionGroup(
      groupKey: const ValueKey('actions-symbol-event'),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in CompanionSymbolOption.values)
              ChoiceChip(
                key: ValueKey('symbol-option-${option.name}'),
                label: Text(
                  option.glyph == null
                      ? option.label
                      : '${option.label} ${option.glyph}',
                ),
                selected: _selected == option,
                onSelected: (_) {
                  setState(() {
                    _selected = option;
                  });
                },
              ),
          ],
        ),
        const SizedBox(height: 10),
        FilledButton(
          key: const ValueKey('symbol-save-button'),
          onPressed: () => widget.onSave(_selected),
          child: const Text('Lagre symbol'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          key: const ValueKey('symbol-skip-button'),
          onPressed: widget.onSkip,
          child: const Text('Hopp over'),
        ),
      ],
    );
  }
}
