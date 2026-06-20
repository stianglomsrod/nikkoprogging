import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/events/companion_event_state_snapshot.dart';
import 'package:companion_app/core/events/drift_companion_event_state_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftCompanionEventStateRepository', () {
    test('persists and reloads companion event snapshot', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftCompanionEventStateRepository(database);

      final before = await repository.readState();
      expect(before, isNull);

      await repository.writeState(
        const CompanionEventStateSnapshot(
          completedTaskCount: 12,
          autoTriggeredEventIds: {
            'event_companion_name',
            'event_user_name',
            'event_sleep_sound',
            'event_background_music',
          },
          handledEventIds: {
            'event_companion_name',
            'event_user_name',
            'event_sleep_sound',
            'event_background_music',
          },
          skippedEventIds: {'event_sleep_sound', 'event_background_music'},
          pendingEventId: 'event_symbol',
        ),
      );

      final after = await repository.readState();
      expect(after, isNotNull);
      expect(after!.completedTaskCount, 12);
      expect(after.pendingEventId, 'event_symbol');
      expect(after.handledEventIds.contains('event_user_name'), isTrue);
      expect(after.skippedEventIds.contains('event_sleep_sound'), isTrue);

      await database.close();
    });

    test('returns null on fresh database (empty state)', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftCompanionEventStateRepository(database);

      final state = await repository.readState();
      expect(state, isNull, reason: 'Fresh DB should hydrate with null');

      await database.close();
    });

    test('succeeds with empty snapshot values', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftCompanionEventStateRepository(database);

      await repository.writeState(
        const CompanionEventStateSnapshot(
          completedTaskCount: 0,
          autoTriggeredEventIds: {},
          handledEventIds: {},
          skippedEventIds: {},
          pendingEventId: null,
        ),
      );

      final after = await repository.readState();
      expect(after, isNotNull);
      expect(after!.completedTaskCount, 0);
      expect(after.pendingEventId, isNull);
      expect(after.autoTriggeredEventIds, isEmpty);

      await database.close();
    });
  });
}
