import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/widgets/custom_search_bar.dart';
import 'package:magic_password/features/home/providers/home_page_provider.dart';
import 'package:magic_password/features/home/states/home_page_state.dart';
import 'package:magic_password/features/home/widgets/header_section.dart';
import 'package:magic_password/features/main/providers/bottom_nav_provider.dart';
import 'package:magic_password/core/widgets/loading_overlay.dart';
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
            child: ListView(
              padding: paddingAllM,
              children: [
                const HeaderSection(),
                verticalSpaceL,
                GestureDetector(
                  onTap: () {
                    ref
                        .read(bottomNavNotifierProvider.notifier)
                        .goToSearchPage();
                  },
                  child: const SearchBarWidget(
                    hintText: 'Search',
                    enabled: false,
                  ),
                ),
                verticalSpaceL,
                const ManagePasswordSection(),
                verticalSpaceL,
                RecentlyUsedSection(
                  passwords: state.recentPasswords,
                  deletePassword: ref
                      .read(homePageNotifierProvider.notifier)
                      .deletePassword,
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
