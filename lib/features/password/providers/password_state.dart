import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic_password/domain/entities/password.dart';

part 'password_state.freezed.dart';

@freezed
class PasswordState with _$PasswordState {
  const factory PasswordState({
    @Default(false) bool isLoading,
    @Default('') String generatedKey,
    @Default('') String generatedPassword,
    @Default('') String encryptedPassword,
    @Default('') String decryptedPassword,
    @Default('') String inputPassword,
    @Default('') String inputKey,
    @Default('') String inputDecryptKey,
    @Default('') String loadedEncryptedPassword,
    @Default(24) int passwordLength,
    @Default([]) List<PasswordEntity> savedPasswords,
  }) = _PasswordState;
}
