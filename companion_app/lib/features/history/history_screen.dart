import 'dart:math';

import 'package:companion_app/core/history/history_repository.dart';
import 'package:companion_app/features/history/widgets/day_activity_bar.dart';
import 'package:companion_app/features/history/widgets/history_empty_state.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
    required this.historyRepository,
    this.nowProvider = DateTime.now,
  });

  final HistoryRepository historyRepository;
  final DateTime Function() nowProvider;

  @override
  Widget build(BuildContext context) {
    final now = nowProvider();
    final today = DateTime(now.year, now.month, now.day);
    final startDate = today.subtract(const Duration(days: 6));

    final daySummaries = historyRepository.readDaySummaries(
      startDate: startDate,
      dayCount: 7,
      includeEmptyDays: true,
    );

    final hasAnyActivity = daySummaries.any((summary) => summary.hasActivity);
    final maxCompletedCount = daySummaries.fold<int>(
      1,
      (currentMax, summary) => max(currentMax, summary.completedTaskCount),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Historikk')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dette var dagene med aktivitet.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Oversikten er rolig og enkel, med én stolpe per dag.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 18),
            Expanded(
              child: hasAnyActivity
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (int i = 0; i < daySummaries.length; i++) ...[
                          if (i > 0) const SizedBox(width: 10),
                          Expanded(
                            child: DayActivityBar(
                              key: ValueKey('history-day-bar-$i'),
                              summary: daySummaries[i],
                              maxCompletedCount: maxCompletedCount,
                              index: i,
                            ),
                          ),
                        ],
                      ],
                    )
                  : const HistoryEmptyState(),
            ),
          ],
        ),
      ),
    );
  }
}
