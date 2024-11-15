import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:magic_password/core/enums/section_enum.dart';

import 'package:magic_password/features/generate_password/views/password_generator_screen.dart';
import 'package:magic_password/features/home/views/home_screen.dart';
import 'package:magic_password/features/main/providers/bottom_nav_provider.dart';
import 'package:magic_password/features/main/widgets/custom_bottom_nav_bar.dart';
import 'package:magic_password/features/search/views/search_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(
      bottomNavNotifierProvider.select((value) => value.currentIndex),
    );

    final screens = [
      const HomeScreen(),
      const Center(child: Text('History')),
      const PasswordGeneratorScreen(),
      SearchScreen(
        autoFocus: ref.watch(
          bottomNavNotifierProvider
              .select((value) => value.params['autoFocus'] ?? false),
        ),
        initSection: ref.watch(
          bottomNavNotifierProvider
              .select((value) => value.params['initSection'] as SectionEnum?),
        ),
        showFilterSheet: ref.watch(
          bottomNavNotifierProvider
              .select((value) => value.params['showFilterSheet'] as bool?),
        ),
      ),
      const Center(child: Text('Profile')),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
