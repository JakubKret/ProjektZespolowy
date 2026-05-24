import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bootstrap/reference_data_seed.dart';
import '../providers/app_providers.dart';

const _sessionKey = 'logged_in_donor_id';

String _hashPassword(String password) =>
    sha256.convert(utf8.encode(password)).toString();

Future<int> loginWithCredentials(
  WidgetRef ref, {
  required String email,
  required String password,
}) async {
  final db = ref.read(databaseProvider);
  final workflow = ref.read(donorWorkflowServiceProvider);

  await ReferenceDataSeed.ensureSeeded(db, workflow);

  final profile =
      await db.donorProfileDao.getProfileByEmail(email.trim().toLowerCase());
  if (profile == null) {
    throw Exception('Nie znaleziono konta z tym adresem email.');
  }

  if (profile.passwordHash != _hashPassword(password)) {
    throw Exception('Błędne hasło.');
  }

  await workflow.backfillDerivedDataForDonor(
    donorProfileId: profile.id,
    annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
  );

  ref.read(currentDonorIdProvider.notifier).set(profile.id);
  await _saveSession(profile.id);
  return profile.id;
}

Future<int> registerNewDonor(
  WidgetRef ref, {
  required String email,
  required String password,
  required String firstName,
  required String lastName,
  required String sex,
  required String bloodType,
  required String rhFactor,
}) async {
  final db = ref.read(databaseProvider);
  final workflow = ref.read(donorWorkflowServiceProvider);

  await ReferenceDataSeed.ensureSeeded(db, workflow);

  final existing =
      await db.donorProfileDao.getProfileByEmail(email.trim().toLowerCase());
  if (existing != null) {
    throw Exception('Konto z tym adresem email już istnieje.');
  }

  final donorId = await workflow.createDonorProfile(
    email: email.trim().toLowerCase(),
    passwordHash: _hashPassword(password),
    firstName: firstName.trim(),
    lastName: lastName.trim(),
    birthDate: DateTime(1998, 1, 1),
    sex: sex,
    bloodType: bloodType,
    rhFactor: rhFactor,
  );

  await workflow.backfillDerivedDataForDonor(
    donorProfileId: donorId,
    annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
  );

  ref.read(currentDonorIdProvider.notifier).set(donorId);
  await _saveSession(donorId);
  return donorId;
}

Future<int?> tryRestoreSession(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final donorId = prefs.getInt(_sessionKey);
  if (donorId == null) return null;

  final db = ref.read(databaseProvider);
  final workflow = ref.read(donorWorkflowServiceProvider);

  await ReferenceDataSeed.ensureSeeded(db, workflow);

  final profile = await db.donorProfileDao.getProfileById(donorId);
  if (profile == null) {
    await prefs.remove(_sessionKey);
    return null;
  }

  await workflow.backfillDerivedDataForDonor(
    donorProfileId: donorId,
    annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
  );

  ref.read(currentDonorIdProvider.notifier).set(donorId);
  return donorId;
}

Future<int?> loginWithBiometrics(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final donorId = prefs.getInt(_sessionKey);
  if (donorId == null) {
    throw Exception(
      'Nie znaleziono zapisanej sesji. Zaloguj się najpierw za pomocą email i hasła.',
    );
  }

  final db = ref.read(databaseProvider);
  final workflow = ref.read(donorWorkflowServiceProvider);

  await ReferenceDataSeed.ensureSeeded(db, workflow);

  final profile = await db.donorProfileDao.getProfileById(donorId);
  if (profile == null) {
    await prefs.remove(_sessionKey);
    throw Exception('Profil został usunięty. Zarejestruj się ponownie.');
  }

  await workflow.backfillDerivedDataForDonor(
    donorProfileId: donorId,
    annualIncomePln: ReferenceDataSeed.defaultAnnualIncomePln,
  );

  ref.read(currentDonorIdProvider.notifier).set(donorId);
  return donorId;
}

Future<void> logout(WidgetRef ref) async {
  ref.read(currentDonorIdProvider.notifier).clear();
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_sessionKey);
}

Future<void> _saveSession(int donorId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_sessionKey, donorId);
}
