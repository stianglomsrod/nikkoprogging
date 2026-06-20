import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/history/drift_history_repository.dart';
import 'package:companion_app/core/history/history_entry.dart';
import 'package:companion_app/core/models/sinnsstemning.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftHistoryRepository', () {
    test('persists and reloads timeline entries', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftHistoryRepository(database);
      await repository.initialize();

      repository.appendEntries([
        HistoryMoodRecord(
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 20, 9, 0),
          focusAreaId: 'study',
        ),
        HistoryAttemptRecord(
          taskId: 'task-1',
          focusAreaId: 'study',
          outcome: HistoryAttemptOutcome.completed,
          mood: Sinnsstemning.ok,
          timestamp: DateTime(2026, 6, 20, 9, 5),
          taskTitleSnapshot: 'Ta fem minutter med matte',
          wasEnergiskChainFollowUp: true,
        ),
        HistoryEventRecord(
          eventId: 'event_symbol',
          action: HistoryEventAction.saved,
          timestamp: DateTime(2026, 6, 20, 9, 8),
          label: 'Symbol valgt',
        ),
      ]);
      await repository.flushPendingWritesForTest();

      final reloadedRepository = DriftHistoryRepository(database);
      await reloadedRepository.initialize();

      final entries = reloadedRepository.readEntriesForDay(
        DateTime(2026, 6, 20),
      );
      expect(entries, hasLength(3));

      final mood = entries[0] as HistoryMoodRecord;
      final attempt = entries[1] as HistoryAttemptRecord;
      final event = entries[2] as HistoryEventRecord;

      expect(mood.mood, Sinnsstemning.ok);
      expect(mood.focusAreaId, 'study');
      expect(attempt.taskTitleSnapshot, 'Ta fem minutter med matte');
      expect(attempt.wasEnergiskChainFollowUp, isTrue);
      expect(event.eventId, 'event_symbol');
      expect(event.action, HistoryEventAction.saved);

      final summaries = reloadedRepository.readDaySummaries(
        startDate: DateTime(2026, 6, 20),
        dayCount: 1,
      );
      expect(summaries.first.completedTaskCount, 1);
      expect(summaries.first.moodEntryCount, 1);
      expect(summaries.first.eventMarkers, hasLength(1));

      await reloadedRepository.close();
    });
  });
}
