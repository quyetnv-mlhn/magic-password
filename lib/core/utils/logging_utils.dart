import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

/// Custom log printer that includes timestamp and custom formatting
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
  String getTime(DateTime time) {
    return DateFormat('HH:mm:ss.SSS').format(time);
  }
}

/// Custom log filter that only shows logs in debug mode
class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}

/// Singleton logger instance
class LoggerUtils {
  static Logger? _instance;

  static Logger get instance {
    _instance ??= Logger(
      filter: CustomLogFilter(),
      printer: CustomLogPrinter(),
      output: ConsoleOutput(),
    );
    return _instance!;
  }

  // Prevent instantiation
  LoggerUtils._();

  /// Log debug message
  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    instance.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log info message
  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    instance.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log warning message
  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    instance.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log error message
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    instance.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log trace message
  static void t(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    instance.t(message, error: error, stackTrace: stackTrace);
  }

  /// Log fatal message
  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    instance.f(message, error: error, stackTrace: stackTrace);
  }
}
