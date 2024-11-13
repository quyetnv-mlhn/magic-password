import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/features/home/providers/home_page_provider.dart';
import 'package:magic_password/features/home/states/home_page_state.dart';
import 'package:magic_password/features/home/widgets/header_section.dart';
import 'package:magic_password/features/home/widgets/search_bar_widget.dart';
import 'package:magic_password/features/password/widgets/loading_overlay.dart';
import 'package:magic_password/features/home/widgets/manage_password_section.dart';
import 'package:magic_password/features/home/widgets/recently_used_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homePageNotifierProvider);

    return homeState.when(
      loading: () => const LoadingOverlay(),
      error: (error, stack) => const SizedBox.shrink(),
      data: (state) => HomeScreenContent(state: state),
    );
  }
}

class HomeScreenContent extends ConsumerWidget {
  final HomePageState state;

  const HomeScreenContent({required this.state, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(homePageNotifierProvider);
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const HeaderSection(),
                      verticalSpaceL,
                      const SearchBarWidget(),
                      verticalSpaceL,
                      const ManagePasswordSection(),
                      verticalSpaceL,
                      RecentlyUsedSection(
                        passwords: state.recentPasswords,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (state.isLoading) const LoadingOverlay(),
      ],
    );
  }
}

class CurvedTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final double radius;

  CurvedTextPainter(this.text, this.textStyle, {this.radius = 100});

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    final anglePerChar = 2 * pi / text.length;

    for (int i = 0; i < text.length; i++) {
      final character = text[i];
      textPainter
        ..text = TextSpan(text: character, style: textStyle)
        ..layout();

      final offsetAngle = -pi / 2 + anglePerChar * i;
      final offset = Offset(
        radius * cos(offsetAngle) - textPainter.width / 2,
        radius * sin(offsetAngle) - textPainter.height / 2,
      );

      canvas
        ..save()
        ..translate(size.width / 2 + offset.dx, size.height / 2 + offset.dy)
        ..rotate(offsetAngle + pi / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CurvedTextPainter oldDelegate) => oldDelegate.text != text;
}
