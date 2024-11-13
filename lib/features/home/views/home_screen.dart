import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magic_password/app/providers/master_key_provider.dart';
import 'package:magic_password/app/providers/password_handler_provider.dart';
import 'package:magic_password/core/configs/app_sizes.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/features/home/providers/home_page_provider.dart';
import 'package:magic_password/features/password/widgets/loading_overlay.dart';

import 'package:magic_password/domain/entities/password/password.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homePageNotifierProvider);

    return homeState.when(
      loading: () => const LoadingOverlay(),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
      data: (state) {
        return Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      verticalSpaceL,
                      _buildSearchBar(),
                      verticalSpaceL,
                      _buildManagePasswordSection(context),
                      verticalSpaceL,
                      _buildRecentlyUsedSection(context, state.recentPasswords),
                    ],
                  ),
                ),
              ),
              if (state.isLoading) const LoadingOverlay(),
            ],
          ),
          bottomNavigationBar: _buildBottomNavBar(),
        );
      },
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              getGreeting(),
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
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          horizontalSpaceS,
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildManagePasswordSection(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Manage Password',
              style: textTheme.titleMedium
                  ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: textTheme.titleSmall
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
        verticalSpaceM,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCategoryCard(
              context,
              icon: Icons.people,
              title: 'Social',
              color: Colors.blue,
            ),
            _buildCategoryCard(
              context,
              icon: Icons.apps,
              title: 'Apps',
              color: Colors.orange,
            ),
            _buildCategoryCard(
              context,
              icon: Icons.credit_card,
              title: 'Card',
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    final sideLength = (width - spaceM * 4) / 3;

    return Container(
      width: sideLength,
      height: sideLength,
      padding: paddingAllM,
      constraints: BoxConstraints(maxHeight: sideLength, maxWidth: sideLength),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: CircleAvatar(
                  radius: (constraints.maxWidth - spaceM * 2) / 2,
                  backgroundColor: context.theme.colorScheme.surface,
                  child: Icon(
                    icon,
                    color: color,
                    size: constraints.maxWidth - spaceM * 3,
                  ),
                ),
              ),
              verticalSpaceS,
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: context.textTheme.titleSmall,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRecentlyUsedSection(
    BuildContext context,
    List<PasswordEntity> recentPasswords,
  ) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently Used',
                  style: textTheme.titleMedium
                      ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Show all',
                    style: textTheme.titleSmall
                        ?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            verticalSpaceM,
            Visibility(
              visible: recentPasswords.isNotEmpty,
              replacement: const SizedBox(
                height: 100,
                child: Center(child: Text('No recent passwords')),
              ),
              child: Column(
                children: recentPasswords
                    .map(
                      (e) => _buildPasswordItem(
                        context,
                        icon: e.accountType.icon,
                        title: e.accountType.name,
                        email: e.accountCredential,
                        encryptedPassword: e.encryptedValue,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordItem(
    BuildContext context, {
    required String icon,
    required String title,
    required String email,
    required String encryptedPassword,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final colors = context.colorScheme;
        final textTheme = context.textTheme;

        Future<void> handleCopyPassword() async {
          final masterKeyNotifier =
              ref.read(masterKeyNotifierProvider.notifier);

          if (!masterKeyNotifier.isInitialized) {
            final masterKey = await showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                String? masterKey;
                return AlertDialog(
                  title: const Text('Enter Master Key'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Master Key',
                          hintText: 'Enter your master key',
                        ),
                        onChanged: (value) => masterKey = value,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Note: This key will only be used for the current '
                        'session. You can change or clear it in Settings.',
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.error,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, masterKey),
                      child: const Text('Confirm'),
                    ),
                  ],
                );
              },
            );

            if (masterKey != null && masterKey.isNotEmpty) {
              masterKeyNotifier.setMasterKey(masterKey);
            } else {
              return;
            }
          }

          final decryptedPassword =
              await ref.read(passwordHandlerProvider.notifier).decryptPassword(
                    masterKey: ref.read(masterKeyNotifierProvider)!,
                    encryptedPassword: encryptedPassword,
                  );
          if (decryptedPassword != null) {
            await Clipboard.setData(ClipboardData(text: decryptedPassword));
            if (!context.mounted) {
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password copied to clipboard'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            masterKeyNotifier.clearMasterKey();
          }
        }

        return Container(
          padding: paddingAllS,
          margin: EdgeInsets.only(bottom: spaceS),
          decoration: BoxDecoration(
            color: colors.secondaryContainer,
            borderRadius: BorderRadius.circular(radiusM),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: iconXL,
                height: iconXL,
                placeholderBuilder: (context) => SizedBox.square(
                  dimension: iconXL,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
              horizontalSpaceM,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium
                        ?.copyWith(color: colors.onSecondaryContainer),
                  ),
                  verticalSpaceXS,
                  Text(
                    email,
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: handleCopyPassword,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
  // Widget _buildPasswordItem({
  //   required String icon,
  //   required String title,
  //   required String email,
  // }) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     child: Row(
  //       children: [
  //         SvgPicture.asset(
  //           icon,
  //           width: iconL,
  //           height: iconL,
  //         ),
  //         horizontalSpaceM,
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                 ),
  //               ),
  //               Text(
  //                 email,
  //                 style: TextStyle(
  //                   color: Colors.grey[600],
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.more_vert),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
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
