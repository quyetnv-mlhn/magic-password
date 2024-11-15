import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/gen/assets.gen.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colorScheme;

    return ColoredBox(
      color: Colors.black.withOpacity(0.3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Container(
            padding: paddingAllL,
            decoration: BoxDecoration(
              color: colors.secondaryContainer,
              borderRadius: BorderRadius.circular(radiusM),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLoadingIndicator(),
                verticalSpaceM,
                Text(
                  LocaleKeys.messages_processing.tr(),
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.onSecondaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return kIsWeb
        ? const CircularProgressIndicator.adaptive()
        : Lottie.asset(
            Assets.jsons.loadingLotie,
            width: 100.w,
            height: 100.w,
          );
  }
}
