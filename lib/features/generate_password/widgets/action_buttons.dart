import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/utils/snackbar_handler.dart';
import 'package:magic_password/features/generate_password/providers/password_generator_provider.dart';
import 'package:magic_password/features/generate_password/widgets/encryption_key_dialog.dart';

class ActionButtons extends ConsumerWidget {
  const ActionButtons({
    required this.password,
    required this.canSave,
    super.key,
  });

  final String password;
  final bool canSave;

  Future<void> _showEncryptionKeyDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => const EncryptionKeyDialog(),
    );

    if (result == true) {
      ref.read(passwordGeneratorNotifierProvider.notifier).savePassword();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _copyToClipboard(context, colors, textTheme),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.secondaryContainer,
                  foregroundColor: colors.onSecondaryContainer,
                  padding: paddingVM,
                ),
                icon: const Icon(Icons.copy),
                label: const Text('Copy to clipboard'),
              ),
            ),
            horizontalSpaceM,
            _RefreshButton(),
          ],
        ),
        verticalSpaceM,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed:
                canSave ? () => _showEncryptionKeyDialog(context, ref) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primaryContainer,
              foregroundColor: colors.onPrimaryContainer,
              padding: paddingVM,
            ),
            icon: const Icon(Icons.save),
            label: const Text('Save password with encryption'),
          ),
        ),
      ],
    );
  }

  void _copyToClipboard(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    Clipboard.setData(ClipboardData(text: password));
    SnackBarHandler.showSuccess('Password copied to clipboard');
  }
}

class _RefreshButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          ref
              .read(passwordGeneratorNotifierProvider.notifier)
              .refreshPassword();
        },
        icon: Icon(
          Icons.refresh,
          color: colors.onTertiaryContainer,
        ),
      ),
    );
  }
}
