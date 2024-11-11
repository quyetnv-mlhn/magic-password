import 'package:freezed_annotation/freezed_annotation.dart';

part 'password.freezed.dart';
part 'password.g.dart';

@freezed
class PasswordEntity with _$PasswordEntity {
  const factory PasswordEntity({
    required String name,
    required String encryptedValue,
    String? key,
    @Default(false) bool isSaved,
  }) = _PasswordEntity;

  factory PasswordEntity.fromJson(Map<String, dynamic> json) =>
      _$PasswordEntityFromJson(json);
}
