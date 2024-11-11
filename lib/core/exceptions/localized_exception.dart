import 'package:easy_localization/easy_localization.dart';

abstract class LocalizedException implements Exception {
  final String messageKey;
  final Map<String, String>? args;

  const LocalizedException({
    required this.messageKey,
    this.args,
  });

  String getLocalizedMessage() {
    return messageKey.tr(namedArgs: args);
  }
}
