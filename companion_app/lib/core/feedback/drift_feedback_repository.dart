import 'package:companion_app/core/database/app_database.dart';
import 'package:companion_app/core/feedback/feedback_item.dart';
import 'package:companion_app/core/feedback/feedback_repository.dart';
import 'package:drift/drift.dart' as drift;

class DriftFeedbackRepository implements FeedbackRepository {
  DriftFeedbackRepository(this._database);

  final AppDatabase _database;

  @override
  Future<void> append(FeedbackItem item) {
    return _database.into(_database.feedbackItems).insertOnConflictUpdate(
      FeedbackItemsCompanion.insert(
        id: item.id,
        createdAtMs: item.createdAtMs,
        feedbackType: item.type.name,
        message: item.message,
        appVersion: drift.Value(item.appVersion),
        screenContext: drift.Value(item.screenContext),
        updatedAtMs: drift.Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  @override
  Future<List<FeedbackItem>> readAll() async {
    final rows = await (_database.select(_database.feedbackItems)
          ..orderBy([(table) => drift.OrderingTerm.desc(table.createdAtMs)]))
        .get();

    return rows.map(_mapRowToItem).toList(growable: false);
  }

  @override
  Future<FeedbackItem?> readById(String id) async {
    final row = await (_database.select(
      _database.feedbackItems,
    )..where((table) => table.id.equals(id))).getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _mapRowToItem(row);
  }

  FeedbackItem _mapRowToItem(FeedbackItemRow row) {
    return FeedbackItem(
      id: row.id,
      createdAtMs: row.createdAtMs,
      type: _feedbackTypeFromName(row.feedbackType),
      message: row.message,
      appVersion: row.appVersion,
      screenContext: row.screenContext,
    );
  }

  FeedbackType _feedbackTypeFromName(String value) {
    for (final option in FeedbackType.values) {
      if (option.name == value) {
        return option;
      }
    }
    return FeedbackType.general;
  }
}
