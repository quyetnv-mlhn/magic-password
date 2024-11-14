import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/features/generate_password/providers/password_generator_provider.dart';

class EncryptionKeyDialog extends ConsumerStatefulWidget {
  const EncryptionKeyDialog({super.key});

  @override
  ConsumerState<EncryptionKeyDialog> createState() =>
      _EncryptionKeyDialogState();
}

class _EncryptionKeyDialogState extends ConsumerState<EncryptionKeyDialog> {
  final _encryptionKeyController = TextEditingController();
  bool _isTextObscured = true;

  @override
  void dispose() {
    _encryptionKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        'Enter Encryption Key',
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _encryptionKeyController,
            obscureText: _isTextObscured,
            decoration: InputDecoration(
              hintText: 'Enter your key',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radiusS),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isTextObscured ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () =>
                    setState(() => _isTextObscured = !_isTextObscured),
              ),
            ),
          ),
          verticalSpaceM,
          Text(
            'Note: This key will only be used for the current session. '
            'You can change or clear it in Settings.',
            style: textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            ref
                .read(passwordGeneratorNotifierProvider.notifier)
                .updateEncryptionKey(_encryptionKeyController.text);
            Navigator.pop(context, true);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
