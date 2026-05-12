import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../workflow_models.dart';

class ReferenceDataWorkflowService {
  final AppDatabase _db;

  ReferenceDataWorkflowService(this._db);

  Future<void> syncBloodCenters(List<BloodCenterSyncInput> centers) async {
    await _db.transaction(() async {
      for (final center in centers) {
        final existing =
            await (_db.select(_db.bloodCentersTable)
                  ..where(
                    (t) => t.name.equals(center.name) & t.city.equals(center.city),
                  ))
                .getSingleOrNull();
        final companion = BloodCentersTableCompanion(
          name: Value(center.name),
          city: Value(center.city),
          address: Value(center.address),
          latitude: Value(center.latitude),
          longitude: Value(center.longitude),
          isMobile: Value(center.isMobile),
          phone: Value(center.phone),
          operatingHoursJson: Value(center.operatingHoursJson),
        );
        if (existing == null) {
          await _db.bloodCentersDao.createCenter(
            BloodCentersTableCompanion.insert(
              name: center.name,
              city: center.city,
              address: Value(center.address),
              latitude: Value(center.latitude),
              longitude: Value(center.longitude),
              isMobile: Value(center.isMobile),
              phone: Value(center.phone),
              operatingHoursJson: Value(center.operatingHoursJson),
            ),
          );
        } else {
          await (_db.update(_db.bloodCentersTable)..where((t) => t.id.equals(existing.id)))
              .write(companion);
        }
      }
    });
  }
}
