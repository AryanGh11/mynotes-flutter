import 'package:logger/logger.dart';

final logger = Logger();

void log(String message) {
  logger.d(message);
}

void logError(String message) {
  logger.e(message);
}
