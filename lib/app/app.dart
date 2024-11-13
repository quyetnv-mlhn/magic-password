import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/features/main/views/main_screen.dart';

class App extends StatelessWidget {
  const App({required this.darkTheme, required this.lightTheme, super.key});

  final ThemeData darkTheme;
  final ThemeData lightTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Password',
      scaffoldMessengerKey: SnackBarHandler.scaffoldMessengerKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MainScreen(),
    );
  }
}
