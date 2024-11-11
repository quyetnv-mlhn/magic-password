import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get appLocalizations {
    return AppLocalizations.of(this)!;
  }

  // Method to get translations without needing BuildContext directly
  static AppLocalizations getStaticLocalization() {
    final scaffoldMessengerKey = SnackBarHandler.scaffoldMessengerKey;
    return scaffoldMessengerKey?.currentContext?.appLocalizations ??
        AppLocalizations.of(scaffoldMessengerKey!.currentContext!)!;
  }
}
