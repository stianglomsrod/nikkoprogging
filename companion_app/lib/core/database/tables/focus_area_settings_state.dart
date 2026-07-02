import 'package:drift/drift.dart';

@DataClassName('FocusAreaSettingsStateRow')
class FocusAreaSettingsStates extends Table {
  TextColumn get id => text()();

  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get startHour => integer().withDefault(const Constant(8))();
  IntColumn get endHour => integer().withDefault(const Constant(22))();
  TextColumn get activeWindowsJson => text().nullable()();
  TextColumn get modus => text().withDefault(const Constant('avslappet'))();

  BoolColumn get isSelected => boolean().withDefault(const Constant(false))();

  IntColumn get updatedAtMs => integer().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
