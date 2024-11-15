import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/core/widgets/password_item.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class SearchResultList extends StatelessWidget {
  final List<PasswordEntity> passwords;
  final Function(PasswordEntity) deletePassword;

  const SearchResultList({
    required this.passwords,
    required this.deletePassword,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (passwords.isEmpty) {
      return Center(
        child: Text(
          LocaleKeys.search_noResults.tr(),
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
          password: password,
          deletePassword: () => deletePassword(password),
        );
      },
    );
  }
}
