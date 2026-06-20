import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:companion_app/core/settings/focus_area_settings_repository.dart';
import 'package:companion_app/core/settings/focus_area_settings_state_snapshot.dart';
import 'package:drift/drift.dart' as drift;

class DriftFocusAreaSettingsRepository implements FocusAreaSettingsRepository {
  DriftFocusAreaSettingsRepository(this._database);

  final AppDatabase _database;

  @override
  Future<FocusAreaSettingsStateSnapshot?> readState() async {
    final rows = await (_database.select(
      _database.focusAreaSettingsStates,
    )..orderBy([(table) => drift.OrderingTerm.asc(table.id)])).get();

    if (rows.isEmpty) {
      return null;
    }

    final areas = rows
        .map(
          (row) => FocusAreaSettingState(
            id: row.id,
            enabled: row.enabled,
            startHour: row.startHour,
            endHour: row.endHour,
            modus: _modusFromName(row.modus),
          ),
        )
        .toList(growable: false);

    FocusAreaSettingsStateRow? selectedRow;
    for (final row in rows) {
      if (row.isSelected) {
        selectedRow = row;
        break;
      }
    }

    return FocusAreaSettingsStateSnapshot(
      areas: areas,
      selectedAreaId: selectedRow?.id,
    );
  }

  @override
  Future<void> writeState(FocusAreaSettingsStateSnapshot snapshot) {
    return _database.transaction(() async {
      await _database.delete(_database.focusAreaSettingsStates).go();

      if (snapshot.areas.isEmpty) {
        return;
      }

      final selectedAreaId = snapshot.selectedAreaId;
      await _database.batch((batch) {
        batch.insertAll(
          _database.focusAreaSettingsStates,
          snapshot.areas
              .map(
                (area) => FocusAreaSettingsStatesCompanion.insert(
                  id: area.id,
                  enabled: drift.Value(area.enabled),
                  startHour: drift.Value(area.startHour),
                  endHour: drift.Value(area.endHour),
                  modus: drift.Value(area.modus.name),
                  isSelected: drift.Value(area.id == selectedAreaId),
                  updatedAtMs: drift.Value(
                    DateTime.now().millisecondsSinceEpoch,
                  ),
                ),
              )
              .toList(growable: false),
        );
      });
    });
  }

  Modus _modusFromName(String value) {
    for (final option in Modus.values) {
      if (option.name == value) {
        return option;
      }
    }
    return Modus.avslappet;
  }
}
