import 'dart:io';

import 'package:companion_app/core/database/tables/companion_event_state.dart';
import 'package:companion_app/core/database/tables/companion_identity_state.dart';
import 'package:companion_app/core/database/tables/history_entries.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [HistoryEntries, CompanionEventStates, CompanionIdentityStates],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  factory AppDatabase.openAtDefaultLocation() {
    return AppDatabase(_openConnection());
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX idx_history_entries_timestamp ON history_entries(timestamp_ms)',
      );
      await customStatement(
        'CREATE INDEX idx_history_entries_type ON history_entries(entry_type)',
      );
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(companionEventStates);
      }
      if (from < 3) {
        await m.createTable(companionIdentityStates);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'companion_history.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
