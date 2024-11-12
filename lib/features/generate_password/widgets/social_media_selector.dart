import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/app_sizes.dart';
import '../../../domain/entities/social_media/social_media.dart';
import '../providers/password_generator_provider.dart';
import '../providers/social_media_provider.dart';

class SocialMediaSelector extends ConsumerWidget {
  const SocialMediaSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordGeneratorNotifierProvider);
    final socialMedias = ref.watch(socialMediaListProvider);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _showSocialMediaPicker(context, ref, socialMedias),
      child: Container(
        padding: paddingAllM,
        decoration: BoxDecoration(
          color: colors.secondaryContainer,
          borderRadius: BorderRadius.circular(radiusM),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              state.selectedSocialMedia.icon,
              width: iconXL,
              height: iconXL,
              placeholderBuilder: (context) => SizedBox.square(
                dimension: iconXL,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
            horizontalSpaceM,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.selectedSocialMedia.name,
                  style: textTheme.titleMedium,
                ),
                Text(
                  state.userId.isEmpty ? 'user.email@gmail.com' : state.userId,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSocialMediaPicker(
    BuildContext context,
    WidgetRef ref,
    List<SocialMediaEntity> socialMedias,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _SocialMediaList(socialMedias: socialMedias),
    );
  }
}

class _SocialMediaList extends ConsumerWidget {
  const _SocialMediaList({required this.socialMedias});

  final List<SocialMediaEntity> socialMedias;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: socialMedias.length,
      itemBuilder: (context, index) {
        final social = socialMedias[index];
        return ListTile(
          leading: SvgPicture.asset(social.icon, width: iconM),
          title: Text(social.name),
          onTap: () {
            ref
                .read(passwordGeneratorNotifierProvider.notifier)
                .selectSocialMedia(social);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
