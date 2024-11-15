import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:json_theme_plus/json_theme_plus.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:magic_password/firebase_options.dart';

import 'package:magic_password/gen/assets.gen.dart';
import 'package:magic_password/gen/codegen_loader.g.dart';

Future<void> bootstrap(
  Widget Function({
    required ThemeData lightTheme,
    required ThemeData darkTheme,
  }) builder,
) async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await EasyLocalization.ensureInitialized();
    initSnackbar();

    final themes = await _loadThemes();
    final lightTheme = themes['light']!;
    final darkTheme = themes['dark']!;

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        assetLoader: const CodegenLoader(),
        child: ProviderScope(
          observers: [MyObserver()],
          child: ScreenUtilInit(
            designSize: const Size(412, 915),
            builder: (context, child) =>
                builder(darkTheme: darkTheme, lightTheme: lightTheme),
          ),
        ),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

Future<Map<String, ThemeData>> _loadThemes() async {
  final themePaths = {
    'light': Assets.jsons.themes.appThemeLight,
    'dark': Assets.jsons.themes.appThemeDark,
  };

  final themes = await Future.wait(
    themePaths.entries.map(
      (entry) async {
        final jsonStr = await rootBundle.loadString(entry.value);
        return MapEntry(
          entry.key,
          ThemeDecoder.decodeThemeData(jsonDecode(jsonStr))!,
        );
      },
    ),
  );

  return Map.fromEntries(themes);
}

void initSnackbar() {
  SnackBarHandler.scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}

class MyObserver extends ProviderObserver {
  static const String _logPrefix = '🔍 [Provider Observer]';

  String _providerName(ProviderBase provider) =>
      provider.name ?? provider.runtimeType.toString();

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    debugPrint(
      '$_logPrefix 🟢 Provider Initialized\n'
      '├─ Provider: ${_providerName(provider)}\n'
      '└─ Value: $value',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    debugPrint(
      '$_logPrefix 🔴 Provider Disposed\n'
      '└─ Provider: ${_providerName(provider)}',
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
      debugPrint(
        '$_logPrefix 🔄 Provider Updated\n'
        '├─ Provider: ${_providerName(provider)}\n'
        '├─ Previous: $previousValue\n'
        '└─ Current: $newValue',
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

    debugPrint(
      '$_logPrefix ❌ Provider Error\n'
      '├─ Provider: $providerName\n'
      '├─ Error: $error\n'
      '└─ Stack trace: \n$stackTrace',
    );

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: 'Provider Error: $providerName',
    );
  }
}
