import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magic_password/domain/entities/social_media/account_type.dart';
import 'package:magic_password/app/providers/account_type_provider.dart';

import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/features/generate_password/providers/password_generator_provider.dart';

class AccountTypeSelector extends ConsumerWidget {
  const AccountTypeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordGeneratorNotifierProvider);
    final socialMedias = ref.watch(accountTypeListProvider);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _showSocialMediaPicker(context, ref, socialMedias),
      child: Container(
        padding: paddingAllM,
        decoration: BoxDecoration(
          color: colors.primaryContainer,
          borderRadius: BorderRadius.circular(radiusM),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              state.selectedAccountType.icon,
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
                  state.selectedAccountType.name,
                  style: textTheme.titleMedium,
                ),
                Text(
                  state.userId.isEmpty ? 'user.email@gmail.com' : state.userId,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onPrimaryContainer,
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
    List<AccountTypeEntity> socialMedias,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _SocialMediaList(accountTypes: socialMedias),
    );
  }
}

class _SocialMediaList extends ConsumerWidget {
  const _SocialMediaList({required this.accountTypes});

  final List<AccountTypeEntity> accountTypes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: accountTypes.length,
      itemBuilder: (context, index) {
        final type = accountTypes[index];
        return ListTile(
          leading: SvgPicture.asset(type.icon, width: iconM),
          title: Text(type.name),
          onTap: () {
            ref
                .read(passwordGeneratorNotifierProvider.notifier)
                .selectAccountType(type);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
