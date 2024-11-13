import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radiusM),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: context.colorScheme.onSurfaceVariant),
          horizontalSpaceS,
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search passwords...',
                border: InputBorder.none,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: context.colorScheme.primary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
