import 'package:easy_localization/easy_localization.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/gen/locale_keys.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:magic_password/app/providers/password_handler_provider.dart';
import 'package:magic_password/features/password/states/password_state.dart';

part 'password_provider.g.dart';

@Riverpod(keepAlive: true)
class PasswordNotifier extends _$PasswordNotifier {
  late final PasswordHandler _passwordHandler;

  @override
  PasswordState build() {
    _passwordHandler = ref.read(passwordHandlerProvider.notifier);
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
    final newKey = _passwordHandler.generateKey();
    state = state.copyWith(generatedKey: newKey);
  }

  Future<void> generatePassword() async {
    final newPassword = _passwordHandler.generatePassword(
      length: state.passwordLength,
    );
    if (newPassword != null) {
      state = state.copyWith(generatedPassword: newPassword);
    }
  }

  Future<void> encryptPassword() async {
    setLoading(true);
    if (state.inputPassword.isEmpty || state.inputKey.isEmpty) {
      SnackBarHandler.showWarning(
        LocaleKeys.warning_passwordAndKeyRequired.tr(),
      );
      return;
    }
    final encrypted = await _passwordHandler.encryptPassword(
      password: state.inputPassword,
      masterKey: state.inputKey,
    );
    if (encrypted != null) {
      state = state.copyWith(encryptedPassword: encrypted);
    }

    setLoading(false);
  }

  Future<void> decryptPassword(String encryptedText, String key) async {
    setLoading(true);
    final decrypted = await _passwordHandler.decryptPassword(
      encryptedPassword: encryptedText,
      masterKey: key,
    );
    if (decrypted != null) {
      state = state.copyWith(decryptedPassword: decrypted);
    }
    setLoading(false);
  }

  Future<void> savePassword(PasswordEntity password) async {
    if (password.accountCredential.isEmpty || password.encryptedValue.isEmpty) {
      SnackBarHandler.showWarning(
        LocaleKeys.warning_passwordAndNameRequired.tr(),
      );
      return;
    }

    await _passwordHandler.savePassword(password);
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
