import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic_password/domain/entities/social_media/social_media.dart';

part 'password_generator_state.freezed.dart';

@freezed
class PasswordGeneratorState with _$PasswordGeneratorState {
  const factory PasswordGeneratorState({
    required SocialMediaEntity selectedSocialMedia,
    @Default('') String userId,
    @Default('') String generatedPassword,
    @Default(20) int passwordLength,
    @Default(true) bool useUppercase,
    @Default(true) bool useLowercase,
    @Default(true) bool useNumbers,
    @Default(true) bool useSymbols,
  }) = _PasswordGeneratorState;
}
