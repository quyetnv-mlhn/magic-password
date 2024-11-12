import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/configs/app_sizes.dart';
import '../providers/password_generator_provider.dart';

class ActionButtons extends ConsumerWidget {
  const ActionButtons({
    required this.password,
    super.key,
  });

  final String password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _copyToClipboard(context, colors, textTheme),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.secondaryContainer,
              foregroundColor: colors.onSecondaryContainer,
              padding: paddingVM,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radiusM),
              ),
            ),
            icon: const Icon(Icons.copy),
            label: Text('Copy to clipboard', style: textTheme.labelLarge),
          ),
        ),
        horizontalSpaceM,
        _RefreshButton(),
      ],
    );
  }

  void _copyToClipboard(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    Clipboard.setData(ClipboardData(text: password));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Password copied to clipboard',
          style: textTheme.bodyMedium?.copyWith(color: colors.onPrimary),
        ),
        backgroundColor: colors.primary,
      ),
    );
  }
}

class _RefreshButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.tertiaryContainer,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          ref
              .read(passwordGeneratorNotifierProvider.notifier)
              .refreshPassword();
        },
        icon: Icon(
          Icons.refresh,
          color: colors.onTertiaryContainer,
        ),
      ),
    );
  }
}
