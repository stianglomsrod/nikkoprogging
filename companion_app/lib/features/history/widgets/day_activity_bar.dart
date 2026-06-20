import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:flutter/material.dart';

class DayActivityBar extends StatelessWidget {
  const DayActivityBar({
    super.key,
    required this.summary,
    required this.maxCompletedCount,
    this.index,
  });

  final DayHistorySummary summary;
  final int maxCompletedCount;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final completedCount = summary.completedTaskCount;

    final normalizedCompleted =
        maxCompletedCount <= 0 ? 0.0 : completedCount / maxCompletedCount;

    final fillHeight = completedCount > 0
        ? 20.0 + (76.0 * normalizedCompleted)
        : summary.hasActivity
        ? 10.0
        : 6.0;

    final fillColor = completedCount > 0
        ? colorScheme.primary.withValues(alpha: 0.86)
        : colorScheme.outlineVariant.withValues(alpha: 0.65);

    final labelStyle = Theme.of(context).textTheme.labelSmall;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              key: ValueKey('history-bar-fill-${index ?? summary.dayStart.day}'),
              width: 20,
              height: fillHeight,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(_weekdayLabel(summary.dayStart.weekday), style: labelStyle),
      ],
    );
  }

  String _weekdayLabel(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'man';
      case DateTime.tuesday:
        return 'tir';
      case DateTime.wednesday:
        return 'ons';
      case DateTime.thursday:
        return 'tor';
      case DateTime.friday:
        return 'fre';
      case DateTime.saturday:
        return 'lor';
      case DateTime.sunday:
        return 'son';
      default:
        return '';
    }
  }
}
