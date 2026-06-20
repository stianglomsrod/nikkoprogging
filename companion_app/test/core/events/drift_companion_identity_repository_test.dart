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
          symbol: CompanionSymbolOption.moon,
          backgroundTone: CompanionBackgroundTone.deepGreen,
        ),
      );

      final after = await repository.readState();
      expect(after, isNotNull);
      expect(after!.companionName, 'Luna');
      expect(after.userName, 'Eli');
      expect(after.symbol, CompanionSymbolOption.moon);
      expect(after.backgroundTone, CompanionBackgroundTone.deepGreen);
    });

    test('persists empty identity values as null and defaults', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftCompanionIdentityRepository(database);

      await repository.writeState(
        const CompanionIdentityStateSnapshot(
          companionName: null,
          userName: null,
          symbol: CompanionSymbolOption.none,
          backgroundTone: CompanionBackgroundTone.defaultDark,
        ),
      );

      final after = await repository.readState();
      expect(after, isNotNull);
      expect(after!.companionName, isNull);
      expect(after.userName, isNull);
      expect(after.symbol, CompanionSymbolOption.none);
      expect(after.backgroundTone, CompanionBackgroundTone.defaultDark);
    });
  });
}
