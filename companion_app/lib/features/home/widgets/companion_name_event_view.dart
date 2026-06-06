import 'package:companion_app/features/home/widgets/bottom_action_area.dart';
import 'package:flutter/material.dart';

class CompanionNameEventView extends StatefulWidget {
  const CompanionNameEventView({
    super.key,
    required this.onSave,
    required this.onSkip,
  });

  final ValueChanged<String> onSave;
  final VoidCallback onSkip;

  @override
  State<CompanionNameEventView> createState() => _CompanionNameEventViewState();
}

class _CompanionNameEventViewState extends State<CompanionNameEventView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final proposedName = _controller.text.trim();
    final canSave = proposedName.isNotEmpty;

    return BottomActionGroup(
      groupKey: const ValueKey('actions-companion-name-event'),
      children: [
        TextField(
          key: const ValueKey('companion-name-input'),
          controller: _controller,
          onChanged: (_) => setState(() {}),
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Navn',
            hintText: 'Skriv et navn',
          ),
        ),
        const SizedBox(height: 10),
        FilledButton(
          key: const ValueKey('companion-name-save-button'),
          onPressed: canSave ? () => widget.onSave(proposedName) : null,
          child: const Text('Lagre navn'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          key: const ValueKey('companion-name-skip-button'),
          onPressed: widget.onSkip,
          child: const Text('Hopp over'),
        ),
      ],
    );
  }
}
