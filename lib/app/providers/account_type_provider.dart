import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:magic_password/gen/assets.gen.dart';

part 'account_type_provider.g.dart';

@riverpod
List<AccountTypeEntity> accountTypeList(Ref ref) {
  return [
    AccountTypeEntity(
      name: 'Facebook',
      url: 'https://www.facebook.com/',
      icon: Assets.icons.socialMedias.icons8Facebook500,
      section: SectionEnum.social,
    ),
    AccountTypeEntity(
      name: 'Instagram',
      url: 'https://www.instagram.com/',
      icon: Assets.icons.socialMedias.icons8Instagram500,
      section: SectionEnum.social,
    ),
    AccountTypeEntity(
      name: 'LinkedIn',
      url: 'https://www.linkedin.com/',
      icon: Assets.icons.socialMedias.icons8Linkedin500,
      section: SectionEnum.social,
    ),
    AccountTypeEntity(
      name: 'TikTok',
      url: 'https://www.tiktok.com/',
      icon: Assets.icons.socialMedias.icons8Tiktok500,
      section: SectionEnum.social,
    ),
  ];
}
