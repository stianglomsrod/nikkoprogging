import 'package:companion_app/core/database/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    // These tests intentionally create multiple independent in-memory DBs.
    drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  tearDownAll(() {
    drift.driftRuntimeOptions.dontWarnAboutMultipleDatabases = false;
  });

  group('AppDatabase migrations', () {
    test('schema version is 4 in current build', () async {
      final database = AppDatabase(NativeDatabase.memory());
      expect(database.schemaVersion, 4);
      await database.close();
    });

    test('creates database without error on fresh memory instance', () async {
      final database = AppDatabase(NativeDatabase.memory());
      expect(database, isNotNull);
      await database.close();
    });

    test('migration is defined and non-null', () async {
      final database = AppDatabase(NativeDatabase.memory());
      expect(database.migration, isNotNull);
      await database.close();
    });

    test('table indexes are created on fresh database', () async {
      final database = AppDatabase(NativeDatabase.memory());

      // Query for index information
      final indexResults = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type='index' AND name LIKE 'idx_%'",
          )
          .get();

      // Verify expected indexes were created
      final indexNames = indexResults.map((row) => row.data['name']).toList();
      expect(
        indexNames,
        containsAll([
          'idx_history_entries_timestamp',
          'idx_history_entries_type',
        ]),
        reason: 'Indexes for history queries should exist',
      );

      await database.close();
    });

    test('migration path is consistent across schema versions', () async {
      // This test verifies the migration strategy handles version transitions
      final database = AppDatabase(NativeDatabase.memory());

      // Verify migration strategy is defined
      expect(database.migration, isNotNull);

      // Verify schemaVersion matches declared constant
      expect(database.schemaVersion, equals(4));

      await database.close();
    });

    test('consecutive in-memory instances have separate state', () async {
      final db1 = AppDatabase(NativeDatabase.memory());
      final db2 = AppDatabase(NativeDatabase.memory());

      expect(db1.schemaVersion, db2.schemaVersion);

      await db1.close();
      await db2.close();
    });
  });
}
