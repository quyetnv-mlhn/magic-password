import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_type.freezed.dart';
part 'account_type.g.dart';

@freezed
class AccountTypeEntity with _$AccountTypeEntity {
  const factory AccountTypeEntity({
    required String name,
    required String url,
    required String icon,
  }) = _AccountTypeEntity;

  factory AccountTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountTypeEntityFromJson(json);
}
