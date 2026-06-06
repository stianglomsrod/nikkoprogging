import 'package:companion_app/core/events/companion_identity.dart';
import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class BackgroundColorEventView extends StatefulWidget {
  const BackgroundColorEventView({
    super.key,
    required this.onSave,
    required this.onSkip,
  });

  final ValueChanged<CompanionBackgroundTone> onSave;
  final VoidCallback onSkip;

  @override
  State<BackgroundColorEventView> createState() =>
      _BackgroundColorEventViewState();
}

class _BackgroundColorEventViewState extends State<BackgroundColorEventView> {
  CompanionBackgroundTone _selected = CompanionBackgroundTone.defaultDark;

  @override
  Widget build(BuildContext context) {
    return BottomActionGroup(
      groupKey: const ValueKey('actions-background-color-event'),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final option in CompanionBackgroundTone.values)
              ChoiceChip(
                key: ValueKey('background-option-${option.name}'),
                label: Text(option.label),
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
          key: const ValueKey('background-color-save-button'),
          onPressed: () => widget.onSave(_selected),
          child: const Text('Lagre farge'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          key: const ValueKey('background-color-skip-button'),
          onPressed: widget.onSkip,
          child: const Text('Hopp over'),
        ),
      ],
    );
  }
}
