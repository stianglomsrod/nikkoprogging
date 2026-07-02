import 'dart:math';

import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/history/history_repository.dart';
import 'package:companion_app/features/feedback/feedback_action_button.dart';
import 'package:companion_app/features/history/widgets/day_activity_bar.dart';
import 'package:companion_app/features/history/widgets/day_detail_view.dart';
import 'package:companion_app/features/history/widgets/history_empty_state.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
    required this.historyRepository,
    required this.feedbackRepository,
    this.feedbackScreenshotCapture,
    this.nowProvider = DateTime.now,
  });

  final HistoryRepository historyRepository;
  final FeedbackRepository feedbackRepository;
  final FeedbackScreenshotCapture? feedbackScreenshotCapture;
  final DateTime Function() nowProvider;

  @override
  Widget build(BuildContext context) {
    final feedbackCaptureKey = GlobalKey();
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
      appBar: AppBar(
        title: const Text('Historikk'),
        actions: [
          FeedbackActionButton(
            feedbackRepository: feedbackRepository,
            captureKey: feedbackCaptureKey,
            captureScreenshot: feedbackScreenshotCapture,
            screenContext: 'history',
          ),
        ],
      ),
      body: RepaintBoundary(
        key: feedbackCaptureKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Små spor gjennom uken',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'En rolig oversikt med én stolpe per dag.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outlineVariant.withValues(alpha: 0.25),
                  ),
                ),
                child: hasAnyActivity
                    ? SizedBox(
                        height: 210,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            for (int i = 0; i < daySummaries.length; i++) ...[
                              if (i > 0) const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  key: ValueKey('history-day-bar-tap-$i'),
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () => _openDayDetail(
                                    context,
                                    summary: daySummaries[i],
                                  ),
                                  child: DayActivityBar(
                                    key: ValueKey('history-day-bar-$i'),
                                    summary: daySummaries[i],
                                    maxCompletedCount: maxCompletedCount,
                                    index: i,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    : const SizedBox(height: 210, child: HistoryEmptyState()),
              ),
              const SizedBox(height: 10),
              Text(
                'Trykk på en dag for en rolig detaljvisning.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openDayDetail(
    BuildContext context, {
    required DayHistorySummary summary,
  }) async {
    final dayEntries = historyRepository.readEntriesForDay(summary.dayStart);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.88,
          child: DayDetailView(
            day: summary.dayStart,
            summary: summary,
            entries: List<HistoryEntry>.from(dayEntries),
          ),
        );
      },
    );
  }
}
