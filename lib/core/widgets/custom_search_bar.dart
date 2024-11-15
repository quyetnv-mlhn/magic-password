import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;
  final bool enabled;
  final bool autoFocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const SearchBarWidget({
    required this.hintText,
    this.onChanged,
    this.onFilterPressed,
    this.enabled = true,
    this.autoFocus = false,
    this.controller,
    this.focusNode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return Container(
      padding: paddingHM,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radiusM),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: colors.onSurfaceVariant),
          horizontalSpaceS,
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              enabled: enabled,
              autofocus: autoFocus,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: colors.primary,
            ),
            onPressed: enabled ? onFilterPressed : null,
          ),
        ],
      ),
    );
  }
}
