import 'package:magic_password/core/exceptions/app_exception.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class PasswordException extends AppException {
  const PasswordException({
    required super.messageKey,
    super.code,
    super.data,
  });
}

class EncryptionException extends PasswordException {
  const EncryptionException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_encryptPasswordFailed);
}

class DecryptionException extends PasswordException {
  const DecryptionException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_decryptPasswordFailed);
}

class InvalidKeyException extends PasswordException {
  const InvalidKeyException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_invalidKey);
}

class PasswordStorageException extends PasswordException {
  const PasswordStorageException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_failedSavePassword);
}

class PasswordNotFoundException extends PasswordException {
  const PasswordNotFoundException({String? messageKey})
      : super(messageKey: messageKey ?? LocaleKeys.error_passwordNotFound);
}
