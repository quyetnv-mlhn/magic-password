import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/enums/section_enum.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final SectionEnum section;
  final VoidCallback? onTap;

  const CategoryCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.section,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final sideLength = (MediaQuery.sizeOf(context).width - 16 * 4) / 3;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radiusM),
      child: Container(
        width: sideLength,
        height: sideLength,
        padding: paddingAllM,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radiusM),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: sideLength / 4,
              backgroundColor: context.colorScheme.surface,
              child: Icon(icon, color: color, size: sideLength / 3),
            ),
            verticalSpaceS,
            Text(
              title,
              style: context.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
