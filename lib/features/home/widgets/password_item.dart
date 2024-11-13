import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:magic_password/app/providers/master_key_provider.dart';
import 'package:magic_password/app/providers/password_handler_provider.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';

class PasswordItem extends ConsumerWidget {
  final String icon;
  final String title;
  final String email;
  final String encryptedPassword;
  final VoidCallback? onMorePressed;

  const PasswordItem({
    required this.icon,
    required this.title,
    required this.email,
    required this.encryptedPassword,
    super.key,
    this.onMorePressed,
  });

  Future<String?> _showMasterKeyDialog(BuildContext context) async {
    final colors = context.colorScheme;
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String? masterKey;
        return AlertDialog(
          title: const Text('Enter Master Key'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Master Key',
                  hintText: 'Enter your master key',
                ),
                onChanged: (value) => masterKey = value,
              ),
              const SizedBox(height: 8),
              Text(
                'Note: This key will only be used for the current session. '
                'You can change or clear it in Settings.',
                style: TextStyle(
                  fontSize: 12,
                  color: colors.error,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, masterKey),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
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
              encryptedPassword: encryptedPassword,
            );

    if (decryptedPassword != null) {
      if (!context.mounted) {
        return;
      }
      await _copyToClipboard(context, decryptedPassword);
    } else {
      masterKeyNotifier.clearMasterKey();
    }
  }

  Future<void> _copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorScheme;
    final textTheme = context.textTheme;

    return Container(
      padding: paddingAllS,
      margin: EdgeInsets.only(bottom: spaceS),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(radiusM),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
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
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.onSecondaryContainer,
                  ),
                ),
                verticalSpaceXS,
                Text(
                  email,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSecondaryContainer,
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
            onPressed: onMorePressed,
          ),
        ],
      ),
    );
  }
}
