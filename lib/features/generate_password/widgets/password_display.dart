import 'package:flutter/material.dart';
import 'package:magic_password/core/configs/app_sizes.dart';

class PasswordDisplay extends StatelessWidget {
  const PasswordDisplay({
    required this.password,
    super.key,
  });

  final String password;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'Password',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
        verticalSpaceS,
        Container(
          width: double.infinity,
          padding: paddingAllM,
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(radiusM),
          ),
          child: Text(
            password,
            style: textTheme.titleLarge?.copyWith(
              color: colors.onPrimaryContainer,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
