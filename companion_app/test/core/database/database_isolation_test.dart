import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/events/companion_event_state_snapshot.dart';
import 'package:companion_app/core/events/drift_companion_event_state_repository.dart';
import 'package:companion_app/core/events/drift_companion_identity_repository.dart';
import 'package:companion_app/core/history/drift_history_repository.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    // This file validates isolation by creating multiple independent DBs.
    drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  tearDownAll(() {
    drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = false;
  });

  group('Database test isolation and cleanup', () {
    test(
      'each test gets isolated in-memory database (no state bleed)',
      () async {
        final db1 = AppDatabase(NativeDatabase.memory());
        final repo1 = DriftHistoryRepository(db1);
        await repo1.initialize();

        final db2 = AppDatabase(NativeDatabase.memory());
        final repo2 = DriftHistoryRepository(db2);
        await repo2.initialize();

        // Verify each database is independent
        final entries1 = repo1.readEntriesForDay(DateTime(2026, 6, 20));
        final entries2 = repo2.readEntriesForDay(DateTime(2026, 6, 20));

        expect(entries1, isEmpty, reason: 'DB1 should be empty');
        expect(entries2, isEmpty, reason: 'DB2 should be empty');

        await db1.close();
        await db2.close();
      },
    );

    test('companion event state repository isolation', () async {
      final db1 = AppDatabase(NativeDatabase.memory());
      final repo1 = DriftCompanionEventStateRepository(db1);

      final db2 = AppDatabase(NativeDatabase.memory());
      final repo2 = DriftCompanionEventStateRepository(db2);

      // Verify both start with null state
      final state1Before = await repo1.readState();
      final state2Before = await repo2.readState();

      expect(state1Before, isNull, reason: 'Repo1 fresh state should be null');
      expect(state2Before, isNull, reason: 'Repo2 fresh state should be null');

      await db1.close();
      await db2.close();
    });

    test('companion identity repository isolation', () async {
      final db1 = AppDatabase(NativeDatabase.memory());
      final repo1 = DriftCompanionIdentityRepository(db1);

      final db2 = AppDatabase(NativeDatabase.memory());
      final repo2 = DriftCompanionIdentityRepository(db2);

      // Verify both start with null state
      final state1Before = await repo1.readState();
      final state2Before = await repo2.readState();

      expect(state1Before, isNull, reason: 'Repo1 fresh state should be null');
      expect(state2Before, isNull, reason: 'Repo2 fresh state should be null');

      await db1.close();
      await db2.close();
    });

    test('successive read/write cycles maintain isolation', () async {
      final db1 = AppDatabase(NativeDatabase.memory());
      final repo1 = DriftCompanionEventStateRepository(db1);

      final db2 = AppDatabase(NativeDatabase.memory());
      final repo2 = DriftCompanionEventStateRepository(db2);

      // Cycle 1: write to repo1
      await repo1.writeState(
        const CompanionEventStateSnapshot(
          completedTaskCount: 5,
          autoTriggeredEventIds: {},
          handledEventIds: {},
          skippedEventIds: {},
          pendingEventId: null,
        ),
      );

      // Verify state persists in repo1 but not in repo2
      final state1 = await repo1.readState();
      final state2 = await repo2.readState();

      expect(state1!.completedTaskCount, 5, reason: 'Repo1 should persist');
      expect(state2, isNull, reason: 'Repo2 should remain empty');

      await db1.close();
      await db2.close();
    });

    test('database closes without error', () async {
      final db1 = AppDatabase(NativeDatabase.memory());
      final repo1 = DriftHistoryRepository(db1);
      await repo1.initialize();

      expect(
        () async => await db1.close(),
        returnsNormally,
        reason: 'Database should close cleanly',
      );
    });
  });

  group('Test cleanup pattern validation', () {
    test('three-way repository isolation after setup', () async {
      final database = AppDatabase(NativeDatabase.memory());

      final historyRepo = DriftHistoryRepository(database);
      await historyRepo.initialize();

      final eventStateRepo = DriftCompanionEventStateRepository(database);
      final identityRepo = DriftCompanionIdentityRepository(database);

      // Verify all three start empty/null
      final historyEntries = historyRepo.readEntriesForDay(DateTime.now());
      final eventState = await eventStateRepo.readState();
      final identityState = await identityRepo.readState();

      expect(historyEntries, isEmpty);
      expect(eventState, isNull);
      expect(identityState, isNull);

      await database.close();
    });
  });
}
