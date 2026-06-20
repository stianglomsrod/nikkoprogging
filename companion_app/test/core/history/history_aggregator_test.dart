import 'package:companion_app/core/history/history_aggregator.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/models/attempt_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HistoryAggregator', () {
    const aggregator = HistoryAggregator();

    test('Ja attempts increment completedTaskCount', () {
      final entries = aggregator.mapPrototypeData(
        attempts: [
          AttemptEntry(
            taskId: 't1',
            focusAreaId: 'household',
            done: true,
            mood: Sinnsstemning.ok,
            timestamp: DateTime(2026, 6, 20, 10, 00),
          ),
          AttemptEntry(
            taskId: 't2',
            focusAreaId: 'household',
            done: true,
            mood: Sinnsstemning.energisk,
            timestamp: DateTime(2026, 6, 20, 12, 00),
          ),
        ],
      );

      final summaries = aggregator.buildDaySummaries(
        entries: entries,
        startDate: DateTime(2026, 6, 20),
        dayCount: 1,
      );

      expect(summaries, hasLength(1));
      expect(summaries.first.completedTaskCount, 2);
      expect(summaries.first.attemptCount, 2);
      expect(summaries.first.notCompletedAttemptCount, 0);
    });

    test('Nei attempt is activity but not completion', () {
      final entries = aggregator.mapPrototypeData(
        attempts: [
          AttemptEntry(
            taskId: 't1',
            focusAreaId: 'study',
            done: false,
            mood: Sinnsstemning.negativ,
            timestamp: DateTime(2026, 6, 20, 15, 30),
          ),
        ],
      );

      final summaries = aggregator.buildDaySummaries(
        entries: entries,
        startDate: DateTime(2026, 6, 20),
        dayCount: 1,
      );

      expect(summaries.first.completedTaskCount, 0);
      expect(summaries.first.attemptCount, 1);
      expect(summaries.first.notCompletedAttemptCount, 1);
      expect(summaries.first.hasActivity, isTrue);
    });

    test('entries from same day aggregate into one day summary', () {
      final entries = <HistoryEntry>[
        ...aggregator.mapPrototypeData(
          attempts: [
            AttemptEntry(
              taskId: 't1',
              focusAreaId: 'exercise',
              done: true,
              mood: Sinnsstemning.ok,
              timestamp: DateTime(2026, 6, 21, 8, 0),
            ),
          ],
          moods: [
            HistoryMoodRecord(
              mood: Sinnsstemning.energisk,
              timestamp: DateTime(2026, 6, 21, 8, 1),
            ),
            HistoryMoodRecord(
              mood: Sinnsstemning.ok,
              timestamp: DateTime(2026, 6, 21, 11, 4),
            ),
          ],
        ),
      ];

      final summaries = aggregator.buildDaySummaries(
        entries: entries,
        startDate: DateTime(2026, 6, 21),
        dayCount: 1,
      );

      final day = summaries.first;
      expect(day.attemptCount, 1);
      expect(day.completedTaskCount, 1);
      expect(day.moodEntryCount, 2);
      expect(day.moodCounts[Sinnsstemning.energisk], 1);
      expect(day.moodCounts[Sinnsstemning.ok], 1);
      expect(day.activityMoments, hasLength(3));
    });

    test('empty days are returned with zero activity when included', () {
      final summaries = aggregator.buildDaySummaries(
        entries: const <HistoryEntry>[],
        startDate: DateTime(2026, 6, 20),
        dayCount: 3,
      );

      expect(summaries, hasLength(3));
      expect(summaries.every((day) => day.hasActivity == false), isTrue);
      expect(
        summaries.every((day) => day.completedTaskCount == 0),
        isTrue,
      );
    });

    test('event records become timeline markers in summary', () {
      final entries = aggregator.mapPrototypeData(
        attempts: const <AttemptEntry>[],
        events: [
          HistoryEventRecord(
            eventId: 'event_companion_name',
            action: HistoryEventAction.saved,
            timestamp: DateTime(2026, 6, 22, 20, 30),
            label: 'Companion-navn lagret',
          ),
          HistoryEventRecord(
            eventId: 'event_user_name',
            action: HistoryEventAction.skipped,
            timestamp: DateTime(2026, 6, 22, 21, 00),
            label: 'Brukernavn hoppet over',
          ),
        ],
      );

      final summaries = aggregator.buildDaySummaries(
        entries: entries,
        startDate: DateTime(2026, 6, 22),
        dayCount: 1,
      );

      final markers = summaries.first.eventMarkers;
      expect(markers, hasLength(2));
      expect(markers.first.eventId, 'event_companion_name');
      expect(markers.first.label, 'Companion-navn lagret');
      expect(markers.last.eventId, 'event_user_name');
      expect(summaries.first.hasActivity, isTrue);
    });
  });
}
