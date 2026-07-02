import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/events/companion_identity.dart';
import 'package:companion_app/core/events/companion_identity_state_snapshot.dart';
import 'package:companion_app/core/events/drift_companion_identity_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftCompanionIdentityRepository', () {
    test('persists and reloads companion identity values', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftCompanionIdentityRepository(database);

      final before = await repository.readState();
      expect(before, isNull);

      await repository.writeState(
        const CompanionIdentityStateSnapshot(
          companionName: 'Luna',
          userName: 'Eli',
          sleepSound: CompanionSleepSoundOption.waves,
          symbol: CompanionSymbolOption.moon,
          backgroundTone: CompanionBackgroundTone.deepGreen,
        ),
      );

      final after = await repository.readState();
      expect(after, isNotNull);
      expect(after!.companionName, 'Luna');
      expect(after.userName, 'Eli');
      expect(after.sleepSound, CompanionSleepSoundOption.waves);
      expect(after.symbol, CompanionSymbolOption.moon);
      expect(after.backgroundTone, CompanionBackgroundTone.deepGreen);

      await database.close();
    });

    test('persists empty identity values as null and defaults', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftCompanionIdentityRepository(database);

      await repository.writeState(
        const CompanionIdentityStateSnapshot(
          companionName: null,
          userName: null,
          sleepSound: CompanionSleepSoundOption.none,
          symbol: CompanionSymbolOption.none,
          backgroundTone: CompanionBackgroundTone.defaultDark,
        ),
      );

      final after = await repository.readState();
      expect(after, isNotNull);
      expect(after!.companionName, isNull);
      expect(after.userName, isNull);
      expect(after.sleepSound, CompanionSleepSoundOption.none);
      expect(after.symbol, CompanionSymbolOption.none);
      expect(after.backgroundTone, CompanionBackgroundTone.defaultDark);

      await database.close();
    });

    test('returns null on fresh database (empty state)', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftCompanionIdentityRepository(database);

      final state = await repository.readState();
      expect(state, isNull, reason: 'Fresh DB should hydrate with null');

      await database.close();
    });
  });
}
