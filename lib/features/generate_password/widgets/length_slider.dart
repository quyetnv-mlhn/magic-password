import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/configs/app_sizes.dart';
import '../providers/password_generator_provider.dart';

class PasswordLengthSlider extends ConsumerWidget {
  const PasswordLengthSlider({
    required this.length,
    super.key,
  });

  static const _minLength = 8.0;
  static const _maxLength = 32.0;
  static const _divisions = 24;

  final int length;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Password Length', style: textTheme.titleMedium),
            Text('$length', style: textTheme.titleMedium),
          ],
        ),
        verticalSpaceS,
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: colors.primary,
            inactiveTrackColor: colors.surfaceContainerHighest,
            thumbColor: colors.primary,
            overlayShape: SliderComponentShape.noThumb,
          ),
          child: Slider(
            value: length.toDouble(),
            min: _minLength,
            max: _maxLength,
            divisions: _divisions,
            onChanged: (value) {
              ref
                  .read(passwordGeneratorNotifierProvider.notifier)
                  .updatePasswordLength(value.toInt());
            },
          ),
        ),
      ],
    );
  }
}
