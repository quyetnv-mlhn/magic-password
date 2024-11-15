import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

/// Custom log printer with timestamp and custom formatting
class CustomLogPrinter extends PrettyPrinter {
  CustomLogPrinter({
    super.methodCount = 2,
    super.errorMethodCount = 8,
    super.lineLength = 120,
    super.colors = true,
    super.printEmojis = true,
    super.printTime = true,
  });

  @override
  String getTime(DateTime time) => DateFormat('HH:mm:ss.SSS').format(time);
}

/// Custom log filter to show logs only in debug mode
class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => kDebugMode;
}

/// Logger utility with a singleton instance
class LoggerUtils {
  LoggerUtils._(); // Private constructor to prevent instantiation

  static final Logger _instance = Logger(
    filter: CustomLogFilter(),
    printer: CustomLogPrinter(),
    output: ConsoleOutput(),
  );

  static Logger get instance => _instance;

  /// Generic log handler
  static void log({
    required Level level,
    required dynamic message,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _instance.log(level, message, error: error, stackTrace: stackTrace);
  }

  /// Log debug message
  static void d(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      log(
        level: Level.debug,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );

  /// Log info message
  static void i(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      log(
        level: Level.info,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );

  /// Log warning message
  static void w(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      log(
        level: Level.warning,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );

  /// Log error message
  static void e(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      log(
        level: Level.error,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );

  /// Log trace message
  static void t(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      log(
        level: Level.trace,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );

  /// Log fatal message
  static void f(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) =>
      log(
        level: Level.fatal,
        message: message,
        error: error,
        stackTrace: stackTrace,
      );
}
