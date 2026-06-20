import 'dart:collection';

import 'package:companion_app/core/models/sinnsstemning.dart';

class HistoryEventMarker {
  const HistoryEventMarker({
    required this.eventId,
    required this.timestamp,
    this.label,
  });

  final String eventId;
  final DateTime timestamp;
  final String? label;
}

class DayHistorySummary {
  DayHistorySummary({
    required this.dayStart,
    required this.completedTaskCount,
    required this.attemptCount,
    required this.notCompletedAttemptCount,
    required this.interruptedAttemptCount,
    required this.moodEntryCount,
    required Map<Sinnsstemning, int> moodCounts,
    required List<HistoryEventMarker> eventMarkers,
    required List<DateTime> activityMoments,
  }) : moodCounts = UnmodifiableMapView<Sinnsstemning, int>(
         Map<Sinnsstemning, int>.from(moodCounts),
       ),
       eventMarkers = UnmodifiableListView<HistoryEventMarker>(
         List<HistoryEventMarker>.from(eventMarkers),
       ),
       activityMoments = UnmodifiableListView<DateTime>(
         List<DateTime>.from(activityMoments),
       );

  factory DayHistorySummary.empty(DateTime dayStart) {
    return DayHistorySummary(
      dayStart: DateTime(dayStart.year, dayStart.month, dayStart.day),
      completedTaskCount: 0,
      attemptCount: 0,
      notCompletedAttemptCount: 0,
      interruptedAttemptCount: 0,
      moodEntryCount: 0,
      moodCounts: const <Sinnsstemning, int>{},
      eventMarkers: const <HistoryEventMarker>[],
      activityMoments: const <DateTime>[],
    );
  }

  final DateTime dayStart;

  final int completedTaskCount;
  final int attemptCount;
  final int notCompletedAttemptCount;
  final int interruptedAttemptCount;

  final int moodEntryCount;
  final UnmodifiableMapView<Sinnsstemning, int> moodCounts;

  final UnmodifiableListView<HistoryEventMarker> eventMarkers;
  final UnmodifiableListView<DateTime> activityMoments;

  bool get hasActivity {
    return attemptCount > 0 ||
        moodEntryCount > 0 ||
        eventMarkers.isNotEmpty ||
        activityMoments.isNotEmpty;
  }
}
