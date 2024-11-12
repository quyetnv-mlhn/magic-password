import 'package:flutter/material.dart';

import 'app/app.dart';
import 'bootstrap.dart';

void main() {
  bootstrap(
    ({required ThemeData lightTheme, required ThemeData darkTheme}) => App(
      darkTheme: darkTheme,
      lightTheme: lightTheme,
    ),
  );
}
