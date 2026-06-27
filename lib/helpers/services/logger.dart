import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class Logger {
  static final Logger _instance = Logger._internal();
  factory Logger() => _instance;
  Logger._internal();

  void debug(String message) => _log(LogLevel.debug, message);
  void info(String message) => _log(LogLevel.info, message);
  void warning(String message) => _log(LogLevel.warning, message);

  void error(String message, [Object? exception, StackTrace? stackTrace]) {
    _log(LogLevel.error, message);
  }

  void _log(LogLevel level, String message) {
    debugPrint('[${level.name.toUpperCase()}] $message');
  }
}
