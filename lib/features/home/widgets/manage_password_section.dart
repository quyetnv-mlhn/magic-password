import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/features/home/widgets/category_card.dart';
import 'package:magic_password/core/utils/color_utils.dart';

class ManagePasswordSection extends StatelessWidget {
  const ManagePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
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
          children: [
            CategoryCard(
              icon: Icons.people,
              title: 'Social',
              color: ColorUtils.getRandomCardColor(context),
              onTap: () {},
            ),
            CategoryCard(
              icon: Icons.apps,
              title: 'Apps',
              color: ColorUtils.getRandomCardColor(context),
              onTap: () {},
            ),
            CategoryCard(
              icon: Icons.credit_card,
              title: 'Cards',
              color: ColorUtils.getRandomCardColor(context),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
