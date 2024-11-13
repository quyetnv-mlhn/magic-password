import 'package:flutter/material.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    }
    if (hour < 18) {
      return 'Good afternoon';
    }
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getGreeting(),
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[Colors.blue, Colors.purple],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            shadows: [
              Shadow(
                offset: const Offset(3.0, 3.0),
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
