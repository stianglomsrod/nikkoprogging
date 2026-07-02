import 'package:drift/drift.dart';

@DataClassName('CompanionIdentityStateRow')
class CompanionIdentityStates extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get companionName => text().nullable()();
  TextColumn get userName => text().nullable()();
  TextColumn get sleepSound => text().withDefault(const Constant('none'))();
    TextColumn get backgroundMusic =>
      text().withDefault(const Constant('none'))();
  TextColumn get selectedSymbol => text().withDefault(const Constant('none'))();
  TextColumn get backgroundTone =>
      text().withDefault(const Constant('defaultDark'))();
  IntColumn get updatedAtMs => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
