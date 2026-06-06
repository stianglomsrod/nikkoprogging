import 'package:flutter/material.dart';

class PrototypeTimePanel extends StatelessWidget {
  const PrototypeTimePanel({
    super.key,
    required this.value,
    required this.hourLabel,
    required this.onChanged,
  });

  final int value;
  final String hourLabel;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Prototype-tid'),
            const SizedBox(height: 6),
            Text(hourLabel),
            Slider(
              value: value.toDouble(),
              min: 0,
              max: 23,
              divisions: 23,
              label: hourLabel,
              onChanged: (newValue) => onChanged(newValue.round()),
            ),
          ],
        ),
      ),
    );
  }
}
