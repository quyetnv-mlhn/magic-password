import 'package:magic_password/core/exceptions/app_exception.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class ValidationException extends AppException {
  const ValidationException({
    required super.messageKey,
    super.code,
    super.data,
  });
}

class InvalidInputException extends ValidationException {
  const InvalidInputException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_invalidInput);
}

class RequiredFieldException extends ValidationException {
  const RequiredFieldException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_requiredField);
}
