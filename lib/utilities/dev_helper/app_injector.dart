// this class for decler and inject static valus ones

import 'package:dealer/local_db/hive_db_controller.dart';
import 'package:dealer/utilities/dev_helper/logger_controller.dart';

class AppInjector {
  static final newLogger = LoggerController();
  static final localStorage = LocalStorage();
}
