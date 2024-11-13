import 'package:flutter/material.dart';

import 'package:magic_password/app/app.dart';
import 'package:magic_password/bootstrap.dart';

void main() {
  bootstrap(
    ({required ThemeData lightTheme, required ThemeData darkTheme}) => App(
      darkTheme: darkTheme,
      lightTheme: lightTheme,
    ),
  );
}
