import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/configs/app_sizes.dart';
import '../providers/password_generator_provider.dart';

class PasswordOptions extends ConsumerWidget {
  const PasswordOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passwordGeneratorNotifierProvider);
    final notifier = ref.read(passwordGeneratorNotifierProvider.notifier);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OptionTile(
                title: 'Uppercase',
                value: state.useUppercase,
                onChanged: notifier.toggleUppercase,
                textTheme: textTheme,
                colors: colors,
              ),
              _OptionTile(
                title: 'Lowercase',
                value: state.useLowercase,
                onChanged: notifier.toggleLowercase,
                textTheme: textTheme,
                colors: colors,
              ),
            ],
          ),
        ),
        horizontalSpaceL,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OptionTile(
                title: 'Numbers',
                value: state.useNumbers,
                onChanged: notifier.toggleNumbers,
                textTheme: textTheme,
                colors: colors,
              ),
              _OptionTile(
                title: 'Symbols',
                value: state.useSymbols,
                onChanged: notifier.toggleSymbols,
                textTheme: textTheme,
                colors: colors,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.textTheme,
    required this.colors,
  });

  final String title;
  final bool value;
  final VoidCallback onChanged;
  final TextTheme textTheme;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textTheme.titleMedium),
        Transform.scale(
          scale: 1,
          child: Checkbox(
            value: value,
            onChanged: (_) => onChanged(),
            activeColor: colors.primary,
            checkColor: colors.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radiusS),
            ),
          ),
        ),
      ],
    );
  }
}
