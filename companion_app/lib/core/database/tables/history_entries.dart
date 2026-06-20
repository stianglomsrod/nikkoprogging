import 'package:drift/drift.dart';

@DataClassName('HistoryEntryRow')
class HistoryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get timestampMs => integer()();
  TextColumn get entryType => text()();

  TextColumn get taskId => text().nullable()();
  TextColumn get taskTitleSnapshot => text().nullable()();
  TextColumn get focusAreaId => text().nullable()();
  TextColumn get attemptOutcome => text().nullable()();

  TextColumn get mood => text().nullable()();

  TextColumn get eventId => text().nullable()();
  TextColumn get eventAction => text().nullable()();
  TextColumn get eventLabel => text().nullable()();

  BoolColumn get wasEnergiskChainFollowUp =>
      boolean().withDefault(const Constant(false))();
}
