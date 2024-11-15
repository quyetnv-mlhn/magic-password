import 'package:easy_localization/easy_localization.dart';
import 'package:magic_password/app/providers/password_handler_provider.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:magic_password/app/providers/account_type_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:magic_password/gen/locale_keys.g.dart';
import 'package:magic_password/features/generate_password/states/password_generator_state.dart';

part 'password_generator_provider.g.dart';

@riverpod
class PasswordGeneratorNotifier extends _$PasswordGeneratorNotifier {
  late final PasswordHandler _passwordHandler;

  @override
  PasswordGeneratorState build() {
    final socialMedias = ref.read(accountTypeListProvider);
    _passwordHandler = ref.read(passwordHandlerProvider.notifier);
    state = PasswordGeneratorState(selectedAccountType: socialMedias.first);
    _generatePassword();
    return state;
  }

  void updateUserId(String userId) {
    state = state.copyWith(userId: userId);
  }

  void updatePasswordLength(int length) {
    state = state.copyWith(passwordLength: length);
    _generatePassword();
  }

  void updateEncryptionKey(String key) {
    state = state.copyWith(encryptionKey: key);
  }

  void updateOption({
    bool? useUppercase,
    bool? useLowercase,
    bool? useNumbers,
    bool? useSymbols,
  }) {
    state = state.copyWith(
      useUppercase: useUppercase ?? state.useUppercase,
      useLowercase: useLowercase ?? state.useLowercase,
      useNumbers: useNumbers ?? state.useNumbers,
      useSymbols: useSymbols ?? state.useSymbols,
    );

    _generatePassword();
  }

  void selectAccountType(AccountTypeEntity social) {
    state = state.copyWith(selectedAccountType: social);
  }

  void refreshPassword() {
    _generatePassword();
  }

  void toggleUppercase() {
    updateOption(useUppercase: !state.useUppercase);
  }

  void toggleLowercase() {
    updateOption(useLowercase: !state.useLowercase);
  }

  void toggleNumbers() {
    updateOption(useNumbers: !state.useNumbers);
  }

  void toggleSymbols() {
    updateOption(useSymbols: !state.useSymbols);
  }

  Future<void> savePassword() async {
    final encryptedValue = await _passwordHandler.encryptPassword(
      password: state.generatedPassword,
      masterKey: state.encryptionKey,
    );

    if (encryptedValue != null) {
      final password = PasswordEntity(
        accountCredential: state.userId,
        encryptedValue: encryptedValue,
        accountType: state.selectedAccountType,
        createdAt: DateTime.now(),
        lastUsedAt: DateTime.now(),
      );

      if (password.accountCredential.isEmpty ||
          password.encryptedValue.isEmpty) {
        SnackBarHandler.showWarning(
          LocaleKeys.warnings_passwordAndNameRequired.tr(),
        );
        return;
      }
      await _passwordHandler.savePassword(password);
    }
  }

  void _generatePassword() {
    final newOptions = {
      'useUppercase': state.useUppercase,
      'useLowercase': state.useLowercase,
      'useNumbers': state.useNumbers,
      'useSymbols': state.useSymbols,
    };

    // Check if at least one option is true
    final anySelected = newOptions.values.any((option) => option == true);

    if (!anySelected) {
      SnackBarHandler.showWarning(LocaleKeys.warnings_selectAtLeastOne.tr());
      return;
    }
    final password = _passwordHandler.generatePassword(
      length: state.passwordLength,
      useUppercase: state.useUppercase,
      useLowercase: state.useLowercase,
      useNumbers: state.useNumbers,
      useSpecialChars: state.useSymbols,
    );
    if (password != null) {
      state = state.copyWith(generatedPassword: password);
    }
  }
}
