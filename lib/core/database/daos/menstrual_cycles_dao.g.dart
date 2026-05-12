// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menstrual_cycles_dao.dart';

// ignore_for_file: type=lint
mixin _$MenstrualCyclesDaoMixin on DatabaseAccessor<AppDatabase> {
  $MenstrualCyclesTableTable get menstrualCyclesTable =>
      attachedDatabase.menstrualCyclesTable;
  MenstrualCyclesDaoManager get managers => MenstrualCyclesDaoManager(this);
}

class MenstrualCyclesDaoManager {
  final _$MenstrualCyclesDaoMixin _db;
  MenstrualCyclesDaoManager(this._db);
  $$MenstrualCyclesTableTableTableManager get menstrualCyclesTable =>
      $$MenstrualCyclesTableTableTableManager(
        _db.attachedDatabase,
        _db.menstrualCyclesTable,
      );
}
