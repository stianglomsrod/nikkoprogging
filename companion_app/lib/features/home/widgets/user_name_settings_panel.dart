import 'package:flutter/material.dart';

class UserNameSettingsPanel extends StatelessWidget {
  const UserNameSettingsPanel({
    super.key,
    required this.initialName,
    required this.onChanged,
  });

  final String? initialName;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ditt navn', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            const Text('Dette navnet kan brukes i korte, vennlige hilsener.'),
            const SizedBox(height: 10),
            TextFormField(
              key: const ValueKey('settings-user-name-input'),
              initialValue: initialName ?? '',
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Navn',
                hintText: 'Skriv navnet ditt',
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
