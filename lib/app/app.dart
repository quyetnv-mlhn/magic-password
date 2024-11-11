import 'package:flutter/material.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/features/password/view/password_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Password',
      scaffoldMessengerKey: SnackBarHandler.scaffoldMessengerKey,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const PasswordScreen(),
    );
  }
}
