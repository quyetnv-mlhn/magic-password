import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_password/app/providers/master_key_provider.dart';
import 'package:magic_password/app/providers/password_handler_provider.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/core/utils/color_utils.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/domain/entities/password/password.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class PasswordItem extends ConsumerWidget {
  final PasswordEntity password;
  final VoidCallback deletePassword;

  const PasswordItem({
    required this.password,
    required this.deletePassword,
    super.key,
  });

  Future<String?> _showMasterKeyDialog(BuildContext context) async {
    String? masterKey;
    bool isKeyVisible = false;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusM),
          ),
          title: Text(
            LocaleKeys.encryption_enterMasterKey.tr(),
            style: context.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: !isKeyVisible,
                decoration: InputDecoration(
                  labelText: LocaleKeys.encryption_masterKey.tr(),
                  hintText: LocaleKeys.encryption_enterYourMasterKey.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radiusS),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isKeyVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isKeyVisible = !isKeyVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) => masterKey = value,
              ),
              verticalSpaceM,
              Text(
                LocaleKeys.encryption_note.tr(),
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                LocaleKeys.actions_cancel.tr(),
                style: context.textTheme.bodyLarge,
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, masterKey),
              child: Text(
                LocaleKeys.actions_confirm.tr(),
                style: context.textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCopyPassword(BuildContext context, WidgetRef ref) async {
    final masterKeyNotifier = ref.read(masterKeyNotifierProvider.notifier);

    if (!masterKeyNotifier.isInitialized) {
      final masterKey = await _showMasterKeyDialog(context);
      if (masterKey == null) {
        return;
      }
      masterKeyNotifier.setMasterKey(masterKey);
    }

    final decryptedPassword =
        await ref.read(passwordHandlerProvider.notifier).decryptPassword(
              masterKey: ref.read(masterKeyNotifierProvider)!,
              encryptedPassword: password.encryptedValue,
            );

    if (decryptedPassword != null) {
      if (context.mounted) {
        await _copyToClipboard(context, ref, decryptedPassword);
      }
    } else {
      masterKeyNotifier.clearMasterKey();
    }
  }

  Future<void> _copyToClipboard(
    BuildContext context,
    WidgetRef ref,
    String text,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) {
      return;
    }
    ref.read(passwordHandlerProvider.notifier).updatePassword(
          password.copyWith(lastUsedAt: DateTime.now()),
          showSnackbar: false,
        );
    SnackBarHandler.showSuccess('Password copied to clipboard');
  }

  void _showMoreOptions(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusL)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: paddingAllM,
              child: Row(
                children: [
                  SvgPicture.asset(password.accountType.icon, width: iconM),
                  horizontalSpaceM,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          password.accountType.name,
                          style: context.textTheme.titleMedium,
                        ),
                        Text(
                          password.accountCredential,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            ListTile(
              leading: Icon(Icons.delete, color: colors.error),
              title: Text(
                'Delete',
                style:
                    context.textTheme.bodyLarge?.copyWith(color: colors.error),
              ),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Password Confirmation'),
        content: Text(
          'Are you sure you want to delete this password from '
          '${password.accountType.name}?'
          '\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              deletePassword.call();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: context.colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = ColorUtils.getRandomPastelColor(context);

    return Container(
      padding: paddingAllS,
      margin: EdgeInsets.only(bottom: spaceS),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radiusM),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            password.accountType.icon,
            width: iconXL,
            height: iconXL,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
          horizontalSpaceM,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  password.accountType.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                verticalSpaceXS,
                Text(
                  password.accountCredential,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () => _handleCopyPassword(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context, ref),
          ),
        ],
      ),
    );
  }
}
