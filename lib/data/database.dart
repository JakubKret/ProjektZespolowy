// lib/data/database.dart
//
// Drift (SQLite) — lokalana baza danych dla aplikacji HDK
// Wymagane zależności w pubspec.yaml:
//
//   dependencies:
//     drift: ^2.18.0
//     sqlite3_flutter_libs: ^0.5.0
//     path_provider: ^2.1.0
//     path: ^1.9.0
//
//   dev_dependencies:
//     drift_dev: ^2.18.0
//     build_runner: ^2.4.0
//
// Generowanie kodu: dart run build_runner build --delete-conflicting-outputs

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
part 'database.g.dart';

enum DonationType {
  wholeBlood,
  plasma,
  platelets,
}

enum DonorGender {
  /// Mężczyzna: max 6 donacji krwi pełnej/rok, progi ZHDK: 6/12/18/20 L.
  male,

  /// Kobieta: max 4 donacje krwi pełnej/rok, progi ZHDK: 5/10/15/20 L.
  female,
}

/// Poziom odznaki ZHDK (Zasłużony Honorowy Dawca Krwi).
enum ZhdkBadge {
  none,
  bronze,   // K: 5 L  / M: 6 L
  silver,   // K: 10 L / M: 12 L
  gold,     // K: 15 L / M: 18 L
  national, // K+M: 20 L — tytuł MZ "Honorowy Dawca Krwi — Zasłużony dla Zdrowia Narodu"
}

class DonorProfile extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get displayName => text().withLength(min: 1, max: 100)();
  TextColumn get bloodType => text().withLength(min: 2, max: 3).nullable()();
  TextColumn get gender => textEnum<DonorGender>()();
  RealColumn get totalLiters => real().withDefault(const Constant(0.0))();
  TextColumn get currentBadge =>
      textEnum<ZhdkBadge>().withDefault(const Constant('none'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Donations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorId => integer().references(DonorProfile, #id)();
  TextColumn get type => textEnum<DonationType>()();
  DateTimeColumn get date => dateTime()();
  RealColumn get volumeLiters => real()();
  DateTimeColumn get nextEligibleDate => dateTime()();
  TextColumn get centerName => text().nullable()();
  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class MenstrualCycles extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get donorId => integer().references(DonorProfile, #id)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get donationUnlockedAfter => dateTime().nullable()();
  BoolColumn get notificationsSilenced =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class MorphResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get donorId => integer().references(DonorProfile, #id)();
  DateTimeColumn get sampledAt => dateTime()();
  RealColumn get hgb => real().nullable()();

  RealColumn get hct => real().nullable()();

  RealColumn get rbc => real().nullable()();
  RealColumn get wbc => real().nullable()();

  RealColumn get plt => real().nullable()();

  RealColumn get iron => real().nullable()();

  RealColumn get ferritin => real().nullable()();

  TextColumn get rawOcrText => text().nullable()();

  TextColumn get source =>
      text().withDefault(const Constant('manual'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class ScheduledNotifications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get notificationId => integer().unique()();
  IntColumn get donorId => integer().references(DonorProfile, #id)();
  DateTimeColumn get scheduledAt => dateTime()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  BoolColumn get isActive =>
      boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [
  DonorProfile,
  Donations,
  MenstrualCycles,
  MorphResults,
  ScheduledNotifications,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await into(donorProfile).insert(
            DonorProfileCompanion.insert(
              displayName: 'Dawca',
              gender: DonorGender.male,
            ),
          );
        },
        onUpgrade: (Migrator m, int from, int to) async {
        },
      );

  Future<DonorProfileData> getDonorProfile() async {
    return await (select(donorProfile)..where((t) => t.id.equals(1)))
        .getSingle();
  }
  Stream<DonorProfileData> watchDonorProfile() {
    return (select(donorProfile)..where((t) => t.id.equals(1)))
        .watchSingle();
  }
  Future<void> updateDonorProfile(DonorProfileCompanion data) async {
    await (update(donorProfile)..where((t) => t.id.equals(1))).write(data);
  }
  Future<int> addDonation(DonationsCompanion entry) async {
    return await transaction(() async {
      final id = await into(donations).insert(entry);
      final profile = await getDonorProfile();
      final newTotal = profile.totalLiters + entry.volumeLiters.value;
      await updateDonorProfile(
        DonorProfileCompanion(totalLiters: Value(newTotal)),
      );
      return id;
    });
  }

  Future<List<Donation>> getAllDonations() {
    return (select(donations)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get();
  }
  Stream<List<Donation>> watchAllDonations() {
    return (select(donations)
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();
  }

  Future<List<Donation>> getDonationsForYear(int year) {
    final start = DateTime(year, 1, 1);
    final end = DateTime(year, 12, 31, 23, 59, 59);
    return (select(donations)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  Future<Donation?> getLastDonationOfType(DonationType type) async {
    final result = await (select(donations)
          ..where((t) =>
              t.type.equalsValue(type))
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(1))
        .getSingleOrNull();
    return result;
  }

  Future<int> getWholeBloodCountInYear(int year) async {
    final list = await getDonationsForYear(year);
    return list.where((d) => d.type == DonationType.wholeBlood).length;
  }

  Future<void> deleteDonation(int id) async {
    await transaction(() async {
      final donation = await (select(donations)
            ..where((t) => t.id.equals(id)))
          .getSingle();
      await (delete(donations)..where((t) => t.id.equals(id))).go();
      final profile = await getDonorProfile();
      final newTotal =
          (profile.totalLiters - donation.volumeLiters).clamp(0.0, 999.0);
      await updateDonorProfile(
        DonorProfileCompanion(totalLiters: Value(newTotal)),
      );
    });
  }

  Future<int> addMenstrualCycle(MenstrualCyclesCompanion entry) {
    return into(menstrualCycles).insert(entry);
  }
  Future<void> closeMenstrualCycle({
    required int cycleId,
    required DateTime endDate,
  }) async {
    final unlockedAfter = endDate.add(const Duration(days: 3));
    await (update(menstrualCycles)..where((t) => t.id.equals(cycleId))).write(
      MenstrualCyclesCompanion(
        endDate: Value(endDate),
        donationUnlockedAfter: Value(unlockedAfter),
        notificationsSilenced: const Value(false),
      ),
    );
  }

  Future<MenstrualCycle?> getActiveCycle() {
    return (select(menstrualCycles)
          ..where((t) => t.endDate.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<bool> areNotificationsSilenced() async {
    final now = DateTime.now();
    final activeCycle = await getActiveCycle();
    if (activeCycle != null) return true;

    final lastClosed = await (select(menstrualCycles)
          ..where((t) => t.endDate.isNotNull())
          ..orderBy([(t) => OrderingTerm.desc(t.endDate)])
          ..limit(1))
        .getSingleOrNull();

    if (lastClosed?.donationUnlockedAfter != null) {
      return now.isBefore(lastClosed!.donationUnlockedAfter!);
    }
    return false;
  }

  Stream<List<MenstrualCycle>> watchMenstrualCycles() {
    return (select(menstrualCycles)
          ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
        .watch();
  }

  Future<int> addMorphResult(MorphResultsCompanion entry) {
    return into(morphResults).insert(entry);
  }

  Stream<List<MorphResult>> watchMorphResults() {
    return (select(morphResults)
          ..orderBy([(t) => OrderingTerm.desc(t.sampledAt)]))
        .watch();
  }

  Future<MorphResult?> getLatestMorphResult() {
    return (select(morphResults)
          ..orderBy([(t) => OrderingTerm.desc(t.sampledAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  // -------------------------------------------------------------------------
  // DAO — Scheduled Notifications
  // -------------------------------------------------------------------------

  /// Zapisuje zaplanowane powiadomienie.
  Future<int> scheduleNotification(ScheduledNotificationsCompanion entry) {
    return into(scheduledNotifications).insert(
      entry,
      mode: InsertMode.insertOrReplace,
    );
  }

  /// Anuluje powiadomienie (ustawia isActive = false).
  Future<void> cancelNotification(int notificationId) async {
    await (update(scheduledNotifications)
          ..where((t) => t.notificationId.equals(notificationId)))
        .write(
      const ScheduledNotificationsCompanion(isActive: Value(false)),
    );
  }

  /// Anuluje wszystkie aktywne powiadomienia dla dawcy.
  Future<void> cancelAllNotificationsForDonor(int donorId) async {
    await (update(scheduledNotifications)
          ..where((t) =>
              t.donorId.equals(donorId) & t.isActive.equals(true)))
        .write(
      const ScheduledNotificationsCompanion(isActive: Value(false)),
    );
  }

  /// Aktywne zaplanowane powiadomienia.
  Future<List<ScheduledNotification>> getActiveNotifications() {
    return (select(scheduledNotifications)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.scheduledAt)]))
        .get();
  }
}

// ---------------------------------------------------------------------------
// POŁĄCZENIE Z BAZĄ
// ---------------------------------------------------------------------------

/// Otwiera bazę SQLite w katalogu dokumentów aplikacji.
/// Dla produkcji zamień na sqlcipher z kluczem z flutter_secure_storage.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hdk_local.db'));
    return NativeDatabase.createInBackground(file);
  });
}