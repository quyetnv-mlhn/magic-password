import 'package:flutter/material.dart';

class MultilineTextField extends StatelessWidget {
  const MultilineTextField({
    required this.controller,
    required this.labelText,
    super.key,
    this.onChanged,
  });
  final TextEditingController controller;
  final String labelText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      onChanged: onChanged,
    );
  }
}
