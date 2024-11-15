import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/features/home/widgets/category_card.dart';
import 'package:magic_password/core/utils/color_utils.dart';
import 'package:magic_password/features/main/providers/bottom_nav_provider.dart';

class ManagePasswordSection extends ConsumerWidget {
  const ManagePasswordSection({super.key});

  static const _categories = [
    (
      icon: Icons.people,
      title: 'Social',
      section: SectionEnum.social,
    ),
    (
      icon: Icons.apps,
      title: 'Apps',
      section: SectionEnum.app,
    ),
    (
      icon: Icons.credit_card,
      title: 'Cards',
      section: SectionEnum.card,
    ),
  ];

  void _navigateToSearch(
    BuildContext context,
    WidgetRef ref,
    SectionEnum section,
  ) {
    ref.read(bottomNavNotifierProvider.notifier).goToSearchPage(
          showFilterSheet: true,
          initSection: section,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Manage Password',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(bottomNavNotifierProvider.notifier).goToSearchPage(
                      showFilterSheet: true,
                    );
              },
              child: Text(
                'See All',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        verticalSpaceM,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _categories
              .map(
                (category) => CategoryCard(
                  icon: category.icon,
                  title: category.title,
                  color: ColorUtils.getRandomCardColor(context),
                  section: category.section,
                  onTap: () =>
                      _navigateToSearch(context, ref, category.section),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
