import 'package:drift/drift.dart';

@DataClassName('CompanionEventStateRow')
class CompanionEventStates extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get completedTaskCount => integer()();
  TextColumn get autoTriggeredEventIdsJson => text()();
  TextColumn get handledEventIdsJson => text()();
  TextColumn get skippedEventIdsJson => text()();
  TextColumn get pendingEventId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
