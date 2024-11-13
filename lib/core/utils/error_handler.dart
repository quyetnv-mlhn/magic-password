import 'package:easy_localization/easy_localization.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';

import 'package:magic_password/core/utils/logging_utils.dart';

void handleError(dynamic error, StackTrace stackTrace) {
  LoggerUtils.e(error, [error, stackTrace]);
  SnackBarHandler.showError(error.toString().tr());
}
