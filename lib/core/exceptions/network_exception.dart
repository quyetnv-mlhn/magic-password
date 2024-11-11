import 'package:magic_password/core/exceptions/app_exception.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class NetworkException extends AppException {
  const NetworkException({
    required super.messageKey,
    super.code,
    super.data,
  });
}

class NoInternetException extends NetworkException {
  const NoInternetException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_noInternet);
}

class ServerException extends NetworkException {
  const ServerException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_serverError);
}

class TimeoutException extends NetworkException {
  const TimeoutException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_timeout);
}
