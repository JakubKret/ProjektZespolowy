import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import '../../database/app_database.dart';

class BackupService {
  static Future<void> exportBackup() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'hdk.sqlite'));
    if (await file.exists()) {
      await Share.shareXFiles([XFile(file.path)], text: 'Kopia zapasowa bazy danych HDK');
    }
  }

  static Future<bool> importBackup() async {
    final result = await FilePicker.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final sourceFile = File(result.files.single.path!);
      
      await AppDatabase.closeAndReset();

      final dir = await getApplicationDocumentsDirectory();
      final destFile = File(p.join(dir.path, 'hdk.sqlite'));

      await sourceFile.copy(destFile.path);
      return true;
    }
    return false;
  }
}
