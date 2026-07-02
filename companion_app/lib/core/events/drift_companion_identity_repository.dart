import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/events/companion_identity.dart';
import 'package:companion_app/core/events/companion_identity_repository.dart';
import 'package:companion_app/core/events/companion_identity_state_snapshot.dart';
import 'package:drift/drift.dart' as drift;

class DriftCompanionIdentityRepository implements CompanionIdentityRepository {
  DriftCompanionIdentityRepository(this._database);

  static const int _singletonId = 1;

  final AppDatabase _database;

  @override
  Future<CompanionIdentityStateSnapshot?> readState() async {
    final row = await (_database.select(
      _database.companionIdentityStates,
    )..where((table) => table.id.equals(_singletonId))).getSingleOrNull();

    if (row == null) {
      return null;
    }

    return CompanionIdentityStateSnapshot(
      companionName: row.companionName,
      userName: row.userName,
      sleepSound: _sleepSoundFromName(row.sleepSound),
      backgroundMusic: _backgroundMusicFromName(row.backgroundMusic),
      symbol: _symbolFromName(row.selectedSymbol),
      backgroundTone: _backgroundToneFromName(row.backgroundTone),
    );
  }

  @override
  Future<void> writeState(CompanionIdentityStateSnapshot snapshot) {
    return _database
        .into(_database.companionIdentityStates)
        .insertOnConflictUpdate(
          CompanionIdentityStatesCompanion.insert(
            id: drift.Value(_singletonId),
            companionName: drift.Value(snapshot.companionName),
            userName: drift.Value(snapshot.userName),
            sleepSound: drift.Value(snapshot.sleepSound.name),
            backgroundMusic: drift.Value(snapshot.backgroundMusic.name),
            selectedSymbol: drift.Value(snapshot.symbol.name),
            backgroundTone: drift.Value(snapshot.backgroundTone.name),
            updatedAtMs: drift.Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
  }

  CompanionSymbolOption _symbolFromName(String value) {
    for (final option in CompanionSymbolOption.values) {
      if (option.name == value) {
        return option;
      }
    }
    return CompanionSymbolOption.none;
  }

  CompanionSleepSoundOption _sleepSoundFromName(String value) {
    for (final option in CompanionSleepSoundOption.values) {
      if (option.name == value) {
        return option;
      }
    }
    return CompanionSleepSoundOption.none;
  }

  CompanionBackgroundTone _backgroundToneFromName(String value) {
    for (final option in CompanionBackgroundTone.values) {
      if (option.name == value) {
        return option;
      }
    }
    return CompanionBackgroundTone.defaultDark;
  }

  CompanionBackgroundMusicOption _backgroundMusicFromName(String value) {
    for (final option in CompanionBackgroundMusicOption.values) {
      if (option.name == value) {
        return option;
      }
    }
    return CompanionBackgroundMusicOption.none;
  }
}
