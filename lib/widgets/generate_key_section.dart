import 'package:flutter/material.dart';
import 'package:magic_password/widgets/copyable_text.dart';
import 'package:magic_password/widgets/section_tile.dart';

class GenerateKeySection extends StatelessWidget {
  final String generatedKey;
  final VoidCallback onGenerateKey;

  const GenerateKeySection({
    required this.generatedKey,
    required this.onGenerateKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTile(title: '1. Generate Security Key'),
        ElevatedButton.icon(
          icon: const Icon(Icons.vpn_key),
          label: const Text('Generate Key'),
          onPressed: onGenerateKey,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
        if (generatedKey.isNotEmpty)
          CopyableText(label: 'Generated Key:', content: generatedKey),
      ],
    );
  }
}
