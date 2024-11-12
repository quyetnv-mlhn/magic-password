import 'package:easy_localization/easy_localization.dart';
import 'package:magic_password/core/di/providers.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:magic_password/features/generate_password/providers/social_media_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/error_handler.dart';
import '../../../domain/repositories/password_repository.dart';
import '../../../gen/locale_keys.g.dart';
import '../states/password_generator_state.dart';

part 'password_generator_provider.g.dart';

@riverpod
class PasswordGeneratorNotifier extends _$PasswordGeneratorNotifier {
  late final PasswordRepository _repository;

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
    try {
      final encryptedValue = await _repository.encryptPassword(
        state.generatedPassword,
        state.encryptionKey,
      );

      final password = PasswordEntity(
        accountCredential: state.selectedAccountType.name,
        encryptedValue: encryptedValue,
        accountType: state.selectedAccountType,
      );

      if (password.accountCredential.isEmpty ||
          password.encryptedValue.isEmpty) {
        SnackBarHandler.showWarning(
          LocaleKeys.warning_passwordAndNameRequired.tr(),
        );
        return;
      }
      await _repository.savePassword(password);
      SnackBarHandler.showSuccess(LocaleKeys.success_passwordSaved.tr());
    } catch (e, s) {
      handleError(e, s);
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
      SnackBarHandler.showWarning(LocaleKeys.warning_selectAtLeastOne.tr());
      return;
    }
    try {
      final password = _repository.generatePassword(
        length: state.passwordLength,
        useUppercase: state.useUppercase,
        useLowercase: state.useLowercase,
        useNumbers: state.useNumbers,
        useSpecialChars: state.useSymbols,
      );
      state = state.copyWith(generatedPassword: password);
    } catch (e, s) {
      handleError(e, s);
    }
  }

  @override
  PasswordGeneratorState build() {
    final socialMedias = ref.read(socialMediaListProvider);
    _repository = ref.read(passwordRepositoryProvider);
    state = PasswordGeneratorState(selectedAccountType: socialMedias.first);
    _generatePassword();
    return state;
  }
}
