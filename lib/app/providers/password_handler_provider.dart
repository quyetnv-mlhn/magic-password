import 'package:easy_localization/easy_localization.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:magic_password/core/di/providers.dart';
import 'package:magic_password/core/utils/error_handler.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/domain/repositories/password_repository.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

part 'password_handler_provider.g.dart';

@Riverpod(keepAlive: true)
class PasswordHandler extends _$PasswordHandler {
  late final PasswordRepository _repository;

  @override
  void build() {
    _repository = ref.read(passwordRepositoryProvider);
  }

  String generateKey() {
    return _repository.generateKey();
  }

  String? generatePassword({
    int length = 20,
    bool useSpecialChars = true,
    bool useNumbers = true,
    bool useUppercase = true,
    bool useLowercase = true,
  }) {
    try {
      return _repository.generatePassword(
        length: length,
        useSpecialChars: useSpecialChars,
        useNumbers: useNumbers,
        useUppercase: useUppercase,
        useLowercase: useLowercase,
      );
    } catch (e, s) {
      handleError(e, s);
    }
    return null;
  }

  Future<String?> encryptPassword({
    required String masterKey,
    required String password,
  }) async {
    try {
      if (masterKey.isEmpty || password.isEmpty) {
        SnackBarHandler.showWarning(
          LocaleKeys.warning_passwordAndKeyRequired.tr(),
        );
        return null;
      }
      return await _repository.encryptPassword(
        password,
        masterKey,
      );
    } catch (e, s) {
      handleError(e, s);
    }
    return null;
  }

  Future<String?> decryptPassword({
    required String encryptedPassword,
    required String masterKey,
  }) async {
    try {
      if (masterKey.isEmpty || encryptedPassword.isEmpty) {
        SnackBarHandler.showWarning(
          LocaleKeys.warning_passwordAndKeyRequired.tr(),
        );
        return null;
      }
      return await _repository.decryptPassword(
        encryptedPassword,
        masterKey,
      );
    } catch (e, s) {
      handleError(e, s);
    }
    return null;
  }

  Future<bool> savePassword(PasswordEntity password) async {
    if (password.accountCredential.isEmpty || password.encryptedValue.isEmpty) {
      SnackBarHandler.showWarning(
        LocaleKeys.warning_passwordAndNameRequired.tr(),
      );
      return false;
    }

    try {
      await _repository.savePassword(password);
      SnackBarHandler.showSuccess(LocaleKeys.success_passwordSaved.tr());
      return true;
    } catch (e, s) {
      handleError(e, s);
    }
    return false;
  }

  Future<List<PasswordEntity>> loadSavedPasswords() async {
    try {
      return await _repository.getSavedPasswords();
    } catch (e, s) {
      handleError(e, s);
    }
    return [];
  }
}
