// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'morphology_results_dao.dart';

// ignore_for_file: type=lint
mixin _$MorphologyResultsDaoMixin on DatabaseAccessor<AppDatabase> {
  $MorphologyResultsTableTable get morphologyResultsTable =>
      attachedDatabase.morphologyResultsTable;
  MorphologyResultsDaoManager get managers => MorphologyResultsDaoManager(this);
}

class MorphologyResultsDaoManager {
  final _$MorphologyResultsDaoMixin _db;
  MorphologyResultsDaoManager(this._db);
  $$MorphologyResultsTableTableTableManager get morphologyResultsTable =>
      $$MorphologyResultsTableTableTableManager(
        _db.attachedDatabase,
        _db.morphologyResultsTable,
      );
}
