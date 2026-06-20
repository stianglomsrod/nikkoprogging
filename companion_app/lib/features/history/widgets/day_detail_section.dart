import 'package:flutter/material.dart';

class DayDetailSection extends StatelessWidget {
  const DayDetailSection({
    super.key,
    required this.title,
    required this.items,
    this.maxVisibleItems = 7,
  });

  final String title;
  final List<String> items;
  final int maxVisibleItems;

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.take(maxVisibleItems).toList(growable: false);
    final hiddenCount = items.length - visibleItems.length;

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
                for (final item in visibleItems) ...[
                  Text('• $item'),
                  const SizedBox(height: 4),
                ],
                if (hiddenCount > 0)
                  Text(
                    '+ $hiddenCount flere spor denne dagen',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
