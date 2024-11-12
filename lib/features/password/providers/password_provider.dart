import 'package:easy_localization/easy_localization.dart';
import 'package:magic_password/core/di/providers.dart';
import 'package:magic_password/core/utils/error_handler.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/gen/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/repositories/password_repository.dart';
import '../states/password_state.dart';

part 'password_provider.g.dart';

@Riverpod(keepAlive: true)
class PasswordNotifier extends _$PasswordNotifier {
  late final PasswordRepository _repository;

  @override
  PasswordState build() {
    _repository = ref.read(passwordRepositoryProvider);
    _loadSavedPasswordNames();
    return const PasswordState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void updatePasswordLength(int length) {
    state = state.copyWith(passwordLength: length);
  }

  void updateInputKey(String key) {
    state = state.copyWith(inputKey: key);
  }

  void updateInputPassword(String password) {
    state = state.copyWith(inputPassword: password);
  }

  void updateInputDecryptKey(String key) {
    state = state.copyWith(inputDecryptKey: key);
  }

  Future<void> generateKey() async {
    final newKey = _repository.generateKey();
    state = state.copyWith(generatedKey: newKey);
  }

  Future<void> generatePassword() async {
    final newPassword = _repository.generatePassword(
      length: state.passwordLength,
    );
    state = state.copyWith(generatedPassword: newPassword);
  }

  Future<void> encryptPassword() async {
    setLoading(true);
    try {
      if (state.inputPassword.isEmpty || state.inputKey.isEmpty) {
        SnackBarHandler.showWarning(
          LocaleKeys.warning_passwordAndKeyRequired.tr(),
        );
        return;
      }
      final encrypted = await _repository.encryptPassword(
        state.inputPassword,
        state.inputKey,
      );
      state = state.copyWith(encryptedPassword: encrypted);
    } catch (e, s) {
      handleError(e, s);
    } finally {
      setLoading(false);
    }
  }

  Future<void> decryptPassword(String encryptedText, String key) async {
    setLoading(true);
    try {
      final decrypted = await _repository.decryptPassword(
        encryptedText,
        key,
      );
      state = state.copyWith(decryptedPassword: decrypted);
    } catch (e, s) {
      handleError(e, s);
    } finally {
      setLoading(false);
    }
  }

  Future<void> savePassword(String name, String encryptedPassword) async {
    if (name.isEmpty || encryptedPassword.isEmpty) {
      SnackBarHandler.showWarning(
        LocaleKeys.warning_passwordAndNameRequired.tr(),
      );
      return;
    }

    try {
      await _repository.savePassword(
        PasswordEntity(name: name, encryptedValue: encryptedPassword),
      );
      SnackBarHandler.showSuccess(LocaleKeys.saved.tr());
    } catch (e, s) {
      handleError(e, s);
    }
  }

  Future<void> _loadSavedPasswordNames() async {
    try {
      final savedPasswords = await _repository.getSavedPasswords();
      state = state.copyWith(savedPasswords: savedPasswords);
    } catch (e, s) {
      handleError(e, s);
    }
  }

  Future<void> loadEncryptedPassword(PasswordEntity? password) async {
    if (password == null) {
      SnackBarHandler.showWarning(LocaleKeys.warning_passwordNameRequired.tr());
      return;
    }
    state = state.copyWith(
      loadedEncryptedPassword: password.encryptedValue,
    );
  }
}
