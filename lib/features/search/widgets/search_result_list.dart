import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/core/widgets/password_item.dart';
import 'package:magic_password/domain/entities/password/password.dart';

class SearchResultList extends StatelessWidget {
  final List<PasswordEntity> passwords;

  const SearchResultList({
    required this.passwords,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (passwords.isEmpty) {
      return Center(
        child: Text(
          'No passwords found',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: paddingAllM,
      itemCount: passwords.length,
      itemBuilder: (context, index) {
        final password = passwords[index];
        return PasswordItem(
          icon: password.accountType.icon,
          title: password.accountType.name,
          email: password.accountCredential,
          encryptedPassword: password.encryptedValue,
        );
      },
    );
  }
}
