import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../gen/assets.gen.dart';

part 'social_media_provider.g.dart';

@riverpod
List<AccountTypeEntity> socialMediaList(Ref ref) {
  return [
    AccountTypeEntity(
      name: 'Facebook',
      url: 'https://www.facebook.com/',
      icon: Assets.icons.socialMedias.icons8Facebook500,
    ),
    AccountTypeEntity(
      name: 'Instagram',
      url: 'https://www.instagram.com/',
      icon: Assets.icons.socialMedias.icons8Instagram500,
    ),
    AccountTypeEntity(
      name: 'LinkedIn',
      url: 'https://www.linkedin.com/',
      icon: Assets.icons.socialMedias.icons8Linkedin500,
    ),
    AccountTypeEntity(
      name: 'TikTok',
      url: 'https://www.tiktok.com/',
      icon: Assets.icons.socialMedias.icons8Tiktok500,
    ),
  ];
}
