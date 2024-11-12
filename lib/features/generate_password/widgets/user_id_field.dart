import 'package:flutter/material.dart';
import '../../../core/configs/app_sizes.dart';

class UserIdField extends StatelessWidget {
  const UserIdField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'User id',
          style: textTheme.titleMedium?.copyWith(color: colors.onSurface),
        ),
        horizontalSpaceM,
        Expanded(
          child: TextField(
            controller: controller,
            style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
            cursorColor: colors.primary,
            decoration: InputDecoration(
              hintText: 'user.email@gmail.com',
              hintStyle: textTheme.bodyMedium
                  ?.copyWith(color: colors.onSurfaceVariant),
              border: const UnderlineInputBorder(),
              isDense: true,
              contentPadding: paddingVS,
            ),
          ),
        ),
        horizontalSpaceM,
        Icon(
          Icons.check_circle,
          color: colors.primary,
          size: iconM,
        ),
      ],
    );
  }
}
