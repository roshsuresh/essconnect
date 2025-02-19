import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class SdkLogger {
  static late Logger _logger;
  static bool _initialized = false;

  static void init({bool isUAT = false, Level level = Level.debug}) {
    _logger = Logger(
      level: level, // Named parameter for setting the log level
      printer: PrettyPrinter(), // Named parameter for setting the printer
      output: ConsoleOutput(), // Named parameter for setting the output
      filter: (kReleaseMode || !isUAT ) ? ProdLogFilter() : DevelopmentFilter(), // Named parameter for setting the filter
    );
    _initialized = true;
  }

  static void _ensureInitialized() {
    if (!_initialized) {
      throw StateError('SdkLogger is not initialized. Call init() before using the logger.');
    }
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _ensureInitialized();
    _logger.v(message, error: error, stackTrace: stackTrace);
  }
}

class ProdLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (event.level == Level.error || event.level == Level.warning) {
      return true;
    }
    return false;
  }
}

class DevelopmentFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // Log all messages in development
    return true;
  }
}



