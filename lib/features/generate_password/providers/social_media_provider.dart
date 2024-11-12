import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/domain/entities/social_media/social_media.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../gen/assets.gen.dart';

part 'social_media_provider.g.dart';

@riverpod
List<SocialMediaEntity> socialMediaList(Ref ref) {
  return [
    SocialMediaEntity(
      name: 'Facebook',
      url: 'https://www.facebook.com/',
      icon: Assets.icons.socialMedias.icons8Facebook500,
    ),
    SocialMediaEntity(
      name: 'Instagram',
      url: 'https://www.instagram.com/',
      icon: Assets.icons.socialMedias.icons8Instagram500,
    ),
    SocialMediaEntity(
      name: 'LinkedIn',
      url: 'https://www.linkedin.com/',
      icon: Assets.icons.socialMedias.icons8Linkedin500,
    ),
    SocialMediaEntity(
      name: 'TikTok',
      url: 'https://www.tiktok.com/',
      icon: Assets.icons.socialMedias.icons8Tiktok500,
    ),
  ];
}
