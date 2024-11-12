import 'package:easy_localization/easy_localization.dart';
import 'package:magic_password/core/di/providers.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/features/generate_password/providers/social_media_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/error_handler.dart';
import '../../../domain/entities/social_media/social_media.dart';
import '../../../domain/repositories/password_repository.dart';
import '../../../gen/locale_keys.g.dart';
import '../states/password_generator_state.dart';

part 'password_generator_provider.g.dart';

@riverpod
class PasswordGeneratorNotifier extends _$PasswordGeneratorNotifier {
  late final PasswordRepository _repository;

  @override
  PasswordGeneratorState build() {
    final socialMedias = ref.read(socialMediaListProvider);
    _repository = ref.read(passwordRepositoryProvider);
    state = PasswordGeneratorState(selectedSocialMedia: socialMedias.first);
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

  void selectSocialMedia(SocialMediaEntity social) {
    state = state.copyWith(selectedSocialMedia: social);
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
}
