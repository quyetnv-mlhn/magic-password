import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyObserver extends ProviderObserver {
  String _providerName(ProviderBase provider) =>
      provider.name ?? provider.runtimeType.toString();

  static const String green = '\x1B[32m'; // Green color
  static const String red = '\x1B[31m'; // Red color
  static const String yellow = '\x1B[33m'; // Yellow color
  static const String magenta = '\x1B[35m'; // Magenta color
  static const String reset = '\x1B[0m'; // Reset color

  /// Method to check if it's running on Android platform
  bool get _isAndroid => !kIsWeb && (Platform.isAndroid);

  /// Helper method to apply color based on platform
  String _colored(String text, String colorCode) {
    if (_isAndroid) {
      return '$colorCode$text$reset'; // Apply color only on Android
    } else {
      return text; // No color on iOS or Web
    }
  }

  void _printWithSpacing(String log) {
    debugPrint('\n$log\n');
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    _printWithSpacing(
      '${_colored('🟢 PROVIDER INITIALIZED', green)}\n'
      '├─ Provider: ${_colored(_providerName(provider), magenta)}\n'
      '└─ Value: ${_colored(value.toString(), yellow)}',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    _printWithSpacing(
      '${_colored('🔴 PROVIDER DISPOSED', red)}\n'
      '└─ Provider: ${_colored(_providerName(provider), magenta)}',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (previousValue != newValue) {
      _printWithSpacing(
        '${_colored('🔄 PROVIDER UPDATED', yellow)}\n'
        '├─ Provider: ${_colored(_providerName(provider), magenta)}\n'
        '├─ Previous: ${_colored(previousValue.toString(), red)}\n'
        '└─ Current: ${_colored(newValue.toString(), green)}',
      );
    }
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    final providerName = _providerName(provider);

    _printWithSpacing(
      '${_colored('❌ PROVIDER ERROR', red)}\n'
      '├─ Provider: ${_colored(providerName, magenta)}\n'
      '├─ Error: ${_colored(error.toString(), red)}\n'
      '└─ Stack trace: \n$stackTrace',
    );
  }
}
