import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/morphology_results_table.dart';
part 'morphology_results_dao.g.dart';

@DriftAccessor(tables: [MorphologyResultsTable])
class MorphologyResultsDao extends DatabaseAccessor<AppDatabase>
with _$MorphologyResultsDaoMixin {
  MorphologyResultsDao(super.db);

  Future<int> createResult(MorphologyResultsTableCompanion result) async {
    return into(morphologyResultsTable).insert(result);
  }

  Stream<List<MorphologyResultsTableData>> watchResultsForDonor(int donorId) {
    return (select(morphologyResultsTable)
          ..where((t) => t.donorId.equals(donorId))
          ..orderBy([(t) => OrderingTerm.desc(t.resultDate)]))
        .watch();
  }

  Future<List<MorphologyResultsTableData>> getResultsForDonor(int donorId) {
    return (select(morphologyResultsTable)
          ..where((t) => t.donorId.equals(donorId))
          ..orderBy([(t) => OrderingTerm.desc(t.resultDate)]))
        .get();
  }

  Future<void> deleteResult(int resultId) {
    return (delete(morphologyResultsTable)..where((t) => t.id.equals(resultId)))
        .go();
  }
}
