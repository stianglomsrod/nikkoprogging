import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/feedback/drift_feedback_repository.dart';
import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DriftFeedbackRepository', () {
    test('returns empty list on fresh database', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftFeedbackRepository(database);

      final items = await repository.readAll();

      expect(items, isEmpty);
      await database.close();
    });

    test('persists and reads feedback item by id', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftFeedbackRepository(database);

      await repository.append(
        const FeedbackItem(
          id: 'fb_1',
          createdAtMs: 1,
          type: FeedbackType.bug,
          message: 'Skjermen blinker i overgang.',
          appVersion: '1.0.0+1',
          screenContext: 'home',
          screenshotPath: 'C:/temp/screenshot.png',
        ),
      );

      final item = await repository.readById('fb_1');

      expect(item, isNotNull);
      expect(item!.id, 'fb_1');
      expect(item.type, FeedbackType.bug);
      expect(item.message, 'Skjermen blinker i overgang.');
      expect(item.appVersion, '1.0.0+1');
      expect(item.screenContext, 'home');
      expect(item.screenshotPath, 'C:/temp/screenshot.png');

      await database.close();
    });

    test('reads items newest-first by createdAtMs', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftFeedbackRepository(database);

      await repository.append(
        const FeedbackItem(
          id: 'fb_old',
          createdAtMs: 100,
          type: FeedbackType.general,
          message: 'Fint med rolig tone.',
        ),
      );
      await repository.append(
        const FeedbackItem(
          id: 'fb_new',
          createdAtMs: 200,
          type: FeedbackType.suggestion,
          message: 'Kunne hatt raskere vei til historikk.',
        ),
      );

      final items = await repository.readAll();

      expect(items, hasLength(2));
      expect(items.first.id, 'fb_new');
      expect(items.last.id, 'fb_old');

      await database.close();
    });
  });
}
