import 'package:drift/drift.dart';

@DataClassName('FeedbackItemRow')
class FeedbackItems extends Table {
  TextColumn get id => text()();

  IntColumn get createdAtMs => integer()();
  TextColumn get feedbackType => text()();
  TextColumn get message => text()();

  TextColumn get appVersion => text().nullable()();
  TextColumn get screenContext => text().nullable()();

  IntColumn get updatedAtMs => integer().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
