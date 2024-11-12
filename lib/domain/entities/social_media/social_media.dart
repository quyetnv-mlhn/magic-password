import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_media.freezed.dart';
part 'social_media.g.dart';

@freezed
class SocialMediaEntity with _$SocialMediaEntity {
  const factory SocialMediaEntity({
    required String name,
    required String url,
    required String icon,
  }) = _SocialMediaEntity;

  factory SocialMediaEntity.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaEntityFromJson(json);
}
