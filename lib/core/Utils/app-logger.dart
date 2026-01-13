
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  static void info(String message) => _logger.i(message);
  static void debug(String message) => _logger.d(message);
  static void error(String message, [dynamic error]) => _logger.e(message, error: error);
  static void success(String message) => _logger.i('✅ $message');
}