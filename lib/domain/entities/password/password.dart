import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';

part 'password.freezed.dart';
part 'password.g.dart';

@freezed
class PasswordEntity with _$PasswordEntity {
  const PasswordEntity._();

  const factory PasswordEntity({
    required String accountCredential,
    required String encryptedValue,
    AccountTypeEntity? accountType,
    @Default(false) bool isSaved,
  }) = _PasswordEntity;

  factory PasswordEntity.fromJson(Map<String, dynamic> json) =>
      _$PasswordEntityFromJson(json);

  String get keyName {
    final prefix = (accountType != null && accountType!.name.isNotEmpty)
        ? '${accountType!.name}-'
        : '';
    return '$prefix$accountCredential';
  }
}
