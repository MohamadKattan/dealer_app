import 'package:logger/logger.dart';

enum LogLevel { error, info, warning }

class LoggerController {
  final logger = Logger(printer: PrettyPrinter());

  void showLogger(LogLevel level, String msg) {
    switch (level) {
      case LogLevel.error:
        logger.e("Error log", error: msg);
        break;
      case LogLevel.info:
        logger.i(msg);
        break;
      case LogLevel.warning:
        logger.w(msg);
        break;
      default:
        logger.w(msg);
    }
  }
}
