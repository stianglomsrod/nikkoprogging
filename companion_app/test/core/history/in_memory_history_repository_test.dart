import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/history/in_memory_history_repository.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InMemoryHistoryRepository', () {
    test('append and day read preserve order and data', () {
      final repository = InMemoryHistoryRepository();

      repository.appendEntries([
        HistoryMoodRecord(
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 20, 9, 00),
          focusAreaId: 'study',
        ),
        HistoryAttemptRecord(
          taskId: 't1',
          focusAreaId: 'study',
          outcome: HistoryAttemptOutcome.completed,
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 20, 9, 05),
        ),
      ]);

      final entries = repository.readEntriesForDay(DateTime(2026, 6, 20));

      expect(entries, hasLength(2));
      expect(entries.first, isA<HistoryMoodRecord>());
      expect(entries.last, isA<HistoryAttemptRecord>());
      expect(entries.first.timestamp, DateTime(2026, 6, 20, 9, 00));
      expect(entries.last.timestamp, DateTime(2026, 6, 20, 9, 05));
    });

    test('range query returns only entries inside range', () {
      final repository = InMemoryHistoryRepository();

      repository.appendEntries([
        HistoryMoodRecord(
          mood: Sinnsstemning.negativ,
          timestamp: DateTime(2026, 6, 19, 23, 59),
        ),
        HistoryMoodRecord(
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 20, 8, 00),
        ),
        HistoryMoodRecord(
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 21, 8, 00),
        ),
      ]);

      final entries = repository.readEntriesInRange(
        rangeStart: DateTime(2026, 6, 20),
        rangeEndExclusive: DateTime(2026, 6, 21),
      );

      expect(entries, hasLength(1));
      expect((entries.first as HistoryMoodRecord).mood, Sinnsstemning.ok);
    });

    test('day summaries include markers and counts', () {
      final repository = InMemoryHistoryRepository();

      repository.appendEntries([
        HistoryMoodRecord(
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 22, 10, 00),
        ),
        HistoryAttemptRecord(
          taskId: 't1',
          focusAreaId: 'exercise',
          outcome: HistoryAttemptOutcome.completed,
          mood: Sinnsstemning.energisk,
          timestamp: DateTime(2026, 6, 22, 10, 10),
        ),
        HistoryEventRecord(
          eventId: 'event_symbol',
          action: HistoryEventAction.saved,
          timestamp: DateTime(2026, 6, 22, 10, 15),
          label: 'Symbol lagret',
        ),
      ]);

      final summaries = repository.readDaySummaries(
        startDate: DateTime(2026, 6, 22),
        dayCount: 1,
      );

      expect(summaries, hasLength(1));
      final day = summaries.first;
      expect(day.completedTaskCount, 1);
      expect(day.attemptCount, 1);
      expect(day.moodEntryCount, 1);
      expect(day.eventMarkers, hasLength(1));
      expect(day.eventMarkers.first.eventId, 'event_symbol');
    });

    test('clear resets repository state', () {
      final repository = InMemoryHistoryRepository();

      repository.appendEntry(
        HistoryMoodRecord(
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 20, 8, 00),
        ),
      );

      expect(repository.readEntriesForDay(DateTime(2026, 6, 20)), isNotEmpty);

      repository.clear();

      expect(repository.readEntriesForDay(DateTime(2026, 6, 20)), isEmpty);
      expect(
        repository.readDaySummaries(
          startDate: DateTime(2026, 6, 20),
          dayCount: 1,
        ).first.hasActivity,
        isFalse,
      );
    });
  });
}
