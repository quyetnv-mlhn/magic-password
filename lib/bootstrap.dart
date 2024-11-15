import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:json_theme_plus/json_theme_plus.dart';
import 'package:magic_password/app/provider_observer.dart';
import 'package:magic_password/core/utils/logging_utils.dart';
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
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Initialize Firebase and Crashlytics
      await _initializeFirebase();

      // Initialize localization
      await _initializeLocalization();

      // Load themes
      final themes = await _loadThemes();
      final lightTheme = themes['light']!;
      final darkTheme = themes['dark']!;

      // Run the app
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
    },
    _handleError,
  );
}

// Error handling function
void _handleError(Object error, StackTrace stack) {
  LoggerUtils.e(error, stackTrace: stack);
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  runApp(ErrorScreen(error: error.toString(), stackTrace: stack.toString()));
}

// Function to initialize Firebase and Crashlytics
Future<void> _initializeFirebase() async {
  await _initialize(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  });
}

// Function to initialize localization
Future<void> _initializeLocalization() async {
  await _initialize(() async {
    await EasyLocalization.ensureInitialized();
    initSnackbar();
  });
}

// Generic initialization function with error handling
Future<void> _initialize(Future<void> Function() initFunction) async {
  try {
    await initFunction();
  } catch (error, stack) {
    LoggerUtils.e(error, stackTrace: stack);
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    runApp(ErrorScreen(error: error.toString(), stackTrace: stack.toString()));
  }
}

// Function to load themes asynchronously
Future<Map<String, ThemeData>> _loadThemes() async {
  try {
    final themePaths = {
      'light': Assets.jsons.themes.appThemeLight,
      'dark': Assets.jsons.themes.appThemeDark,
    };

    final themes = <String, ThemeData>{};
    for (final entry in themePaths.entries) {
      final jsonStr = await rootBundle.loadString(entry.value);
      themes[entry.key] = ThemeDecoder.decodeThemeData(jsonDecode(jsonStr))!;
    }
    return themes;
  } catch (error, stack) {
    LoggerUtils.e(error, stackTrace: stack);
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    runApp(ErrorScreen(error: error.toString(), stackTrace: stack.toString()));
    rethrow;
  }
}

// Error screen that displays the error message and stack trace
class ErrorScreen extends StatelessWidget {
  final String error;
  final String stackTrace;

  const ErrorScreen({required this.error, required this.stackTrace, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'An error occurred: $error',
                style: TextStyle(color: Colors.red, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Stack Trace:',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                stackTrace,
                style: TextStyle(color: Colors.black87, fontSize: 14),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Initialize Snackbar handler
void initSnackbar() {
  SnackBarHandler.scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}
