import 'dart:convert';

import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/events/companion_event_state_repository.dart';
import 'package:companion_app/core/events/companion_event_state_snapshot.dart';
import 'package:drift/drift.dart' as drift;

class DriftCompanionEventStateRepository implements CompanionEventStateRepository {
  DriftCompanionEventStateRepository(this._database);

  static const int _singletonId = 1;

  final AppDatabase _database;

  @override
  Future<CompanionEventStateSnapshot?> readState() async {
    final row = await (_database.select(_database.companionEventStates)
          ..where((table) => table.id.equals(_singletonId)))
        .getSingleOrNull();

    if (row == null) {
      return null;
    }

    return CompanionEventStateSnapshot(
      completedTaskCount: row.completedTaskCount,
      autoTriggeredEventIds: _decodeSet(row.autoTriggeredEventIdsJson),
      handledEventIds: _decodeSet(row.handledEventIdsJson),
      skippedEventIds: _decodeSet(row.skippedEventIdsJson),
      pendingEventId: row.pendingEventId,
    );
  }

  @override
  Future<void> writeState(CompanionEventStateSnapshot snapshot) {
    return _database
        .into(_database.companionEventStates)
        .insertOnConflictUpdate(
          CompanionEventStatesCompanion.insert(
            id: drift.Value(_singletonId),
            completedTaskCount: snapshot.completedTaskCount,
            autoTriggeredEventIdsJson: _encodeSet(snapshot.autoTriggeredEventIds),
            handledEventIdsJson: _encodeSet(snapshot.handledEventIds),
            skippedEventIdsJson: _encodeSet(snapshot.skippedEventIds),
            pendingEventId: drift.Value(snapshot.pendingEventId),
          ),
        );
  }

  String _encodeSet(Set<String> values) {
    return jsonEncode(values.toList(growable: false));
  }

  Set<String> _decodeSet(String value) {
    final decoded = jsonDecode(value);
    if (decoded is! List) {
      return <String>{};
    }
    return decoded.whereType<String>().toSet();
  }
}
