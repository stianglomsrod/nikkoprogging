import 'package:companion_app/core/history/day_history_summary.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';

class HistoryAggregator {
  const HistoryAggregator();

  List<HistoryEntry> mapPrototypeData({
    required List<AttemptEntry> attempts,
    List<HistoryMoodRecord> moods = const <HistoryMoodRecord>[],
    List<HistoryEventRecord> events = const <HistoryEventRecord>[],
  }) {
    final entries = <HistoryEntry>[
      ...attempts.map(HistoryAttemptRecord.fromAttemptEntry),
      ...moods,
      ...events,
    ];

    entries.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return entries;
  }

  List<DayHistorySummary> buildDaySummaries({
    required List<HistoryEntry> entries,
    required DateTime startDate,
    required int dayCount,
    bool includeEmptyDays = true,
  }) {
    if (dayCount <= 0) {
      throw ArgumentError.value(dayCount, 'dayCount', 'must be >= 1');
    }

    final rangeStart = _atDayStart(startDate);
    final rangeEndExclusive = rangeStart.add(Duration(days: dayCount));
    final accumulators = <DateTime, _DaySummaryAccumulator>{};

    for (final entry in entries) {
      if (entry.timestamp.isBefore(rangeStart) ||
          !entry.timestamp.isBefore(rangeEndExclusive)) {
        continue;
      }

      final dayKey = _atDayStart(entry.timestamp);
      final accumulator = accumulators.putIfAbsent(
        dayKey,
        () => _DaySummaryAccumulator(dayKey),
      );
      accumulator.consume(entry);
    }

    final summaries = <DayHistorySummary>[];
    for (int i = 0; i < dayCount; i++) {
      final dayKey = rangeStart.add(Duration(days: i));
      final summary = accumulators[dayKey]?.toSummary() ??
          DayHistorySummary.empty(dayKey);
      if (includeEmptyDays || summary.hasActivity) {
        summaries.add(summary);
      }
    }

    return summaries;
  }

  DateTime _atDayStart(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}

class _DaySummaryAccumulator {
  _DaySummaryAccumulator(this.dayStart);

  final DateTime dayStart;

  int completedTaskCount = 0;
  int attemptCount = 0;
  int notCompletedAttemptCount = 0;
  int interruptedAttemptCount = 0;
  int moodEntryCount = 0;

  final Map<Sinnsstemning, int> moodCounts = <Sinnsstemning, int>{};
  final List<HistoryEventMarker> eventMarkers = <HistoryEventMarker>[];
  final List<DateTime> activityMoments = <DateTime>[];

  void consume(HistoryEntry entry) {
    activityMoments.add(entry.timestamp);

    if (entry is HistoryAttemptRecord) {
      attemptCount += 1;
      switch (entry.outcome) {
        case HistoryAttemptOutcome.completed:
          completedTaskCount += 1;
          break;
        case HistoryAttemptOutcome.notCompleted:
          notCompletedAttemptCount += 1;
          break;
        case HistoryAttemptOutcome.interrupted:
          interruptedAttemptCount += 1;
          break;
      }
      return;
    }

    if (entry is HistoryMoodRecord) {
      moodEntryCount += 1;
      moodCounts.update(entry.mood, (value) => value + 1, ifAbsent: () => 1);
      return;
    }

    if (entry is HistoryEventRecord) {
      eventMarkers.add(
        HistoryEventMarker(
          eventId: entry.eventId,
          timestamp: entry.timestamp,
          label: entry.label,
        ),
      );
    }
  }

  DayHistorySummary toSummary() {
    return DayHistorySummary(
      dayStart: dayStart,
      completedTaskCount: completedTaskCount,
      attemptCount: attemptCount,
      notCompletedAttemptCount: notCompletedAttemptCount,
      interruptedAttemptCount: interruptedAttemptCount,
      moodEntryCount: moodEntryCount,
      moodCounts: moodCounts,
      eventMarkers: eventMarkers,
      activityMoments: activityMoments,
    );
  }
}
