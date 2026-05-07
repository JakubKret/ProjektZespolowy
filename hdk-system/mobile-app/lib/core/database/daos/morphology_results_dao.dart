import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/menstrual_cycles.dart';
part 'menstrual_cycles_dao.g.dart';
typedef RecalculateCycleBlocker = Future<void>Function(int donorProfileId);