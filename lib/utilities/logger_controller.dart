import 'package:logger/logger.dart';

class LoggerController {
  final logger = Logger(printer: PrettyPrinter());

  void showLogger(String key, String msg) {
    switch (key) {
      case 'e':
        logger.e("Error log", error: msg);
        break;
      case 'i':
        logger.i(msg);
        break;
      case 'w':
        logger.w(msg);
        break;
      default:
        logger.w(msg);
    }
  }
}
