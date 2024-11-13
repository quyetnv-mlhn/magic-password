import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/features/main/providers/bottom_nav_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(
      bottomNavNotifierProvider.select((value) => value.currentIndex),
    );
    final colors = context.colorScheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) =>
          ref.read(bottomNavNotifierProvider.notifier).changeIndex(index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history_outlined),
          activeIcon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          activeIcon: Icon(Icons.add_circle),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: colors.primary,
      unselectedItemColor: colors.onSurfaceVariant,
      showUnselectedLabels: true,
    );
  }
}
