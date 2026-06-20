import 'package:flutter/material.dart';

class DayDetailSection extends StatelessWidget {
  const DayDetailSection({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in items) ...[
                  Text('• $item'),
                  const SizedBox(height: 4),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
