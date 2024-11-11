import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';

import 'gen/codegen_loader.g.dart';

Future<void> bootstrap(Widget Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  initSnackbar();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      assetLoader: const CodegenLoader(),
      child: ProviderScope(
        observers: [MyObserver()],
        child: ScreenUtilInit(
          designSize: const Size(412, 915),
          builder: (context, child) => builder(),
        ),
      ),
    ),
  );
}

void initSnackbar() {
  SnackBarHandler.scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}

class MyObserver extends ProviderObserver {
  static const String _logPrefix = '🔍 [Provider Observer]';

  String _getProviderDebugName(ProviderBase provider) {
    return provider.name ?? provider.runtimeType.toString();
  }

  String _formatValue(Object? value) {
    if (value == null) return 'null';
    if (value is String) return '"$value"';
    return value.toString();
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    debugPrint('''
$_logPrefix Provider Initialized
├─ Provider: ${_getProviderDebugName(provider)}
└─ Value: ${_formatValue(value)}''');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    debugPrint('''
$_logPrefix Provider Disposed
└─ Provider: ${_getProviderDebugName(provider)}''');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // Skip logging if value hasn't changed
    if (previousValue == newValue) return;

    debugPrint('''
$_logPrefix Provider Updated
├─ Provider: ${_getProviderDebugName(provider)}
├─ Previous: ${_formatValue(previousValue)}
└─ Current: ${_formatValue(newValue)}''');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    debugPrint('''
$_logPrefix ❌ Provider Error
├─ Provider: ${_getProviderDebugName(provider)}
├─ Error: $error
└─ Stack trace: 
$stackTrace''');
  }
}
