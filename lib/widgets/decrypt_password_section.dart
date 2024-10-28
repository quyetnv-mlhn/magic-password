import 'package:flutter/material.dart';
import 'package:magic_password/widgets/copyable_text.dart';
import 'package:magic_password/widgets/multiline_text_field.dart';
import 'package:magic_password/widgets/section_tile.dart';

class DecryptPasswordSection extends StatelessWidget {
  final VoidCallback onDecryptPassword;
  final String decryptedPassword;
  final TextEditingController decryptKeyController;
  final TextEditingController encryptedPasswordController;
  final ValueChanged<String> onDecryptKeyChanged;

  const DecryptPasswordSection({
    required this.onDecryptPassword,
    required this.decryptedPassword,
    required this.decryptKeyController,
    required this.encryptedPasswordController,
    required this.onDecryptKeyChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTile(title: '4. Decrypt Password'),
        MultilineTextField(
          controller: decryptKeyController,
          labelText: 'Enter Decryption Key',
          onChanged: onDecryptKeyChanged,
        ),
        const SizedBox(height: 8),
        MultilineTextField(
          controller: encryptedPasswordController,
          labelText: 'Enter Encrypted Password',
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.lock_open),
          label: const Text('Decrypt Password'),
          onPressed: onDecryptPassword,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.purple,
          ),
        ),
        if (decryptedPassword.isNotEmpty)
          CopyableText(
            label: 'Decrypted Password:',
            content: decryptedPassword,
          ),
      ],
    );
  }
}
