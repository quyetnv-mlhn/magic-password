import 'package:flutter/material.dart';

enum MessageType { success, error, warning, info }

class UIMessage {
  final String message;
  final MessageType type;

  const UIMessage({
    required this.message,
    required this.type,
  });

  Color get color {
    switch (type) {
      case MessageType.success:
        return Colors.green;
      case MessageType.error:
        return Colors.red;
      case MessageType.warning:
        return Colors.orange;
      case MessageType.info:
        return Colors.blue;
    }
  }

  IconData get icon {
    switch (type) {
      case MessageType.success:
        return Icons.check_circle;
      case MessageType.error:
        return Icons.error;
      case MessageType.warning:
        return Icons.warning;
      case MessageType.info:
        return Icons.info;
    }
  }
}
