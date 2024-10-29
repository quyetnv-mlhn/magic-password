import 'package:flutter/material.dart';
import 'package:magic_password/widgets/copyable_text.dart';
import 'package:magic_password/widgets/multiline_text_field.dart';
import 'package:magic_password/widgets/section_tile.dart';

class EncryptPasswordSection extends StatelessWidget {
  final VoidCallback onEncryptPassword;
  final String encryptedPassword;
  final TextEditingController keyController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final ValueChanged<String> onKeyChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onSavePassword;
  final ValueChanged<String> onNameChanged;

  const EncryptPasswordSection({
    required this.onEncryptPassword,
    required this.encryptedPassword,
    required this.nameController,
    required this.keyController,
    required this.passwordController,
    required this.onKeyChanged,
    required this.onPasswordChanged,
    required this.onSavePassword,
    required this.onNameChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTile(title: '3. Encrypt Password'),
        MultilineTextField(
          controller: keyController,
          labelText: 'Enter Key',
          onChanged: onKeyChanged,
        ),
        const SizedBox(height: 8),
        MultilineTextField(
          controller: nameController,
          labelText: 'Enter Name (required if saving)',
          onChanged: onNameChanged,
        ),
        const SizedBox(height: 8),
        MultilineTextField(
          controller: passwordController,
          labelText: 'Enter Password',
          onChanged: onPasswordChanged,
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.lock),
          label: const Text('Encrypt Password'),
          onPressed: onEncryptPassword,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
          ),
        ),
        if (encryptedPassword.isNotEmpty) ...[
          CopyableText(
            label: 'Encrypted Password:',
            content: encryptedPassword,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Save Password'),
            onPressed: () {
              final name = nameController.text.trim();
              final password = passwordController.text.trim();
              if (name.isNotEmpty && password.isNotEmpty) {
                onSavePassword(name);
                nameController.clear();
                passwordController.clear();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Name and Password are required'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ],
    );
  }
}
