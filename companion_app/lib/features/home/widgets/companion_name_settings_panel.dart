import 'package:flutter/material.dart';

class CompanionNameSettingsPanel extends StatelessWidget {
  const CompanionNameSettingsPanel({
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
            Text(
              'Companion-navn',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            const Text('Du kan endre navnet når som helst.'),
            const SizedBox(height: 10),
            TextFormField(
              key: const ValueKey('settings-companion-name-input'),
              initialValue: initialName ?? '',
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Navn',
                hintText: 'Skriv et navn',
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
