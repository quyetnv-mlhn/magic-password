import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/password_generator_provider.dart';

class EncryptionKeyDialog extends ConsumerStatefulWidget {
  const EncryptionKeyDialog({super.key});

  @override
  ConsumerState<EncryptionKeyDialog> createState() =>
      _EncryptionKeyDialogState();
}

class _EncryptionKeyDialogState extends ConsumerState<EncryptionKeyDialog> {
  final _keyController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text('Enter Encryption Key', style: textTheme.titleLarge),
      content: TextField(
        controller: _keyController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: 'Enter your key',
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
        ),
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
                .updateEncryptionKey(_keyController.text);
            Navigator.pop(context, true);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
