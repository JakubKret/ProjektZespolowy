import '../database/app_database.dart';

String formatBloodTypeLabel(DonorProfileTableData? profile) {
  if (profile == null) return 'Nie podano';
  final group = profile.bloodType?.trim();
  if (group == null || group.isEmpty) return 'Nie podano';

  final rh = profile.rhFactor?.trim();
  if (rh == null || rh.isEmpty) return group;

  if (rh == '+' || rh.toLowerCase() == 'plus' || rh.toLowerCase() == 'rh+') {
    return '$group Rh+';
  }
  if (rh == '-' || rh.toLowerCase() == 'minus' || rh.toLowerCase() == 'rh-') {
    return '$group Rh-';
  }
  return '$group $rh';
}
