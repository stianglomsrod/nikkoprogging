import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/models/modus.dart';
import 'package:companion_app/core/settings/drift_focus_area_settings_repository.dart';
import 'package:companion_app/core/settings/focus_area_settings_state_snapshot.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftFocusAreaSettingsRepository', () {
    test('returns null on fresh database', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftFocusAreaSettingsRepository(database);

      final state = await repository.readState();

      expect(state, isNull);
      await database.close();
    });

    test('persists and reloads focus-area settings state', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftFocusAreaSettingsRepository(database);

      await repository.writeState(
        const FocusAreaSettingsStateSnapshot(
          selectedAreaId: 'study',
          areas: [
            FocusAreaSettingState(
              id: 'household',
              enabled: false,
              startHour: 10,
              endHour: 18,
              modus: Modus.stabil,
            ),
            FocusAreaSettingState(
              id: 'study',
              enabled: true,
              startHour: 18,
              endHour: 22,
              modus: Modus.sporty,
            ),
          ],
        ),
      );

      final reloaded = await repository.readState();

      expect(reloaded, isNotNull);
      expect(reloaded!.areas, hasLength(2));
      expect(reloaded.selectedAreaId, 'study');

      final household = reloaded.areas.firstWhere((area) => area.id == 'household');
      final study = reloaded.areas.firstWhere((area) => area.id == 'study');

      expect(household.enabled, isFalse);
      expect(household.startHour, 10);
      expect(household.endHour, 18);
      expect(household.modus, Modus.stabil);

      expect(study.enabled, isTrue);
      expect(study.startHour, 18);
      expect(study.endHour, 22);
      expect(study.modus, Modus.sporty);

      await database.close();
    });

    test('replaces previous settings on write', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftFocusAreaSettingsRepository(database);

      await repository.writeState(
        const FocusAreaSettingsStateSnapshot(
          selectedAreaId: 'household',
          areas: [
            FocusAreaSettingState(
              id: 'household',
              enabled: true,
              startHour: 8,
              endHour: 20,
              modus: Modus.avslappet,
            ),
          ],
        ),
      );

      await repository.writeState(
        const FocusAreaSettingsStateSnapshot(
          selectedAreaId: 'exercise',
          areas: [
            FocusAreaSettingState(
              id: 'exercise',
              enabled: true,
              startHour: 12,
              endHour: 19,
              modus: Modus.sporty,
            ),
          ],
        ),
      );

      final reloaded = await repository.readState();

      expect(reloaded, isNotNull);
      expect(reloaded!.areas, hasLength(1));
      expect(reloaded.areas.single.id, 'exercise');
      expect(reloaded.selectedAreaId, 'exercise');

      await database.close();
    });
  });
}
