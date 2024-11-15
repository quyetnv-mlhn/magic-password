import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/core/widgets/password_item.dart';

class RecentlyUsedSection extends StatelessWidget {
  final List<PasswordEntity> passwords;
  final Function(PasswordEntity) deletePassword;

  const RecentlyUsedSection({
    required this.passwords,
    required this.deletePassword,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recently Used',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceM,
        if (passwords.isEmpty)
          Center(
            child: Text(
              'No recently used passwords',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          )
        else
          ...passwords.map(
            (password) => PasswordItem(
              password: password,
              deletePassword: () => deletePassword(password),
            ),
          ),
      ],
    );
  }
}
