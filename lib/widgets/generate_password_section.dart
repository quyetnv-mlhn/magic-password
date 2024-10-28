import 'package:flutter/material.dart';
import 'package:magic_password/widgets/copyable_text.dart';
import 'package:magic_password/widgets/section_tile.dart';

class GeneratePasswordSection extends StatelessWidget {
  final int passwordLength;
  final ValueChanged<int> onPasswordLengthChanged;
  final String generatedPassword;
  final VoidCallback onGeneratePassword;

  const GeneratePasswordSection({
    required this.passwordLength,
    required this.onPasswordLengthChanged,
    required this.generatedPassword,
    required this.onGeneratePassword,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTile(title: '2. Generate Random Password'),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: passwordLength.toDouble(),
                min: 8,
                max: 32,
                divisions: 24,
                label: passwordLength.toString(),
                onChanged: (value) => onPasswordLengthChanged(value.toInt()),
              ),
            ),
            Text('Length: $passwordLength'),
          ],
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.password),
          label: const Text('Generate Password'),
          onPressed: onGeneratePassword,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
          ),
        ),
        if (generatedPassword.isNotEmpty)
          CopyableText(
            label: 'Generated Password:',
            content: generatedPassword,
          ),
      ],
    );
  }
}
