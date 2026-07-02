import 'dart:convert';

import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/models/focus_area.dart';
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
            activeWindows: _decodeActiveWindows(
              rawJson: row.activeWindowsJson,
              fallbackStartHour: row.startHour,
              fallbackEndHour: row.endHour,
            ),
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
              .map((area) {
                final primaryWindow = area.activeWindows.first;
                return FocusAreaSettingsStatesCompanion.insert(
                  id: area.id,
                  enabled: drift.Value(area.enabled),
                  startHour: drift.Value(primaryWindow.startHour),
                  endHour: drift.Value(primaryWindow.endHour),
                  activeWindowsJson: drift.Value(
                    _encodeActiveWindows(area.activeWindows),
                  ),
                  modus: drift.Value(area.modus.name),
                  isSelected: drift.Value(area.id == selectedAreaId),
                  updatedAtMs: drift.Value(
                    DateTime.now().millisecondsSinceEpoch,
                  ),
                );
              })
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

  String _encodeActiveWindows(List<ActiveTimeWindow> windows) {
    return jsonEncode([
      for (final window in windows)
        <String, int>{'startHour': window.startHour, 'endHour': window.endHour},
    ]);
  }

  List<ActiveTimeWindow> _decodeActiveWindows({
    required String? rawJson,
    required int fallbackStartHour,
    required int fallbackEndHour,
  }) {
    if (rawJson == null || rawJson.isEmpty) {
      return <ActiveTimeWindow>[
        ActiveTimeWindow(
          startHour: fallbackStartHour,
          endHour: fallbackEndHour,
        ),
      ];
    }

    final decoded = jsonDecode(rawJson);
    if (decoded is! List) {
      return <ActiveTimeWindow>[
        ActiveTimeWindow(
          startHour: fallbackStartHour,
          endHour: fallbackEndHour,
        ),
      ];
    }

    final windows = <ActiveTimeWindow>[];
    for (final item in decoded) {
      if (item is! Map) {
        continue;
      }
      final startHour = item['startHour'];
      final endHour = item['endHour'];
      if (startHour is int && endHour is int) {
        windows.add(ActiveTimeWindow(startHour: startHour, endHour: endHour));
      }
    }

    if (windows.isEmpty) {
      return <ActiveTimeWindow>[
        ActiveTimeWindow(
          startHour: fallbackStartHour,
          endHour: fallbackEndHour,
        ),
      ];
    }

    return windows;
  }
}
