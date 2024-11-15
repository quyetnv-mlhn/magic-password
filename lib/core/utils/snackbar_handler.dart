import 'package:flutter/material.dart';
import 'package:magic_password/core/extensions/theme_ext.dart';
import 'package:magic_password/gen/locale_keys.g.dart';

import 'package:magic_password/core/configs/app_sizes.dart';

class SnackBarHandler {
  static final SnackBarHandler _instance = SnackBarHandler._internal();

  factory SnackBarHandler() => _instance;

  SnackBarHandler._internal();

  static GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  static void showSnackBar({
    required String message,
    required IconData icon,
    required Color backgroundColor,
    String? title,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    EdgeInsets? margin,
    EdgeInsets? padding,
    bool isDismissible = true,
    DismissDirection dismissDirection = DismissDirection.vertical,
    VoidCallback? onTap,
  }) {
    BuildContext? context = scaffoldMessengerKey?.currentContext;
    if (scaffoldMessengerKey?.currentState == null || context == null) {
      return;
    }

    scaffoldMessengerKey?.currentState?.clearSnackBars();

    final snackBar = SnackBar(
      content: AnimatedSnackBarContent(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      dismissDirection: dismissDirection,
      margin: margin ?? paddingAllXS,
      padding: padding ?? paddingAllS,
    );

    scaffoldMessengerKey?.currentState?.showSnackBar(snackBar);
  }

  static void showError(String? message, {String? title}) {
    showSnackBar(
      title: title,
      message: message ?? LocaleKeys.messages_someThingWentWrong,
      backgroundColor: Colors.red,
      icon: Icons.error_outline,
    );
  }

  static void showSuccess(String? message, {String? title}) {
    showSnackBar(
      title: title,
      message: message ?? LocaleKeys.messages_someThingWentWrong,
      backgroundColor: Colors.green,
      icon: Icons.check_circle_outline,
    );
  }

  static void showInfo(String message, {String? title}) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info_outline,
    );
  }

  static void showWarning(String message, {String? title}) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning_amber_rounded,
    );
  }
}

// A custom widget to handle the sliding animation for the SnackBar's content
class AnimatedSnackBarContent extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final IconData icon;

  const AnimatedSnackBarContent({
    required this.message,
    required this.backgroundColor,
    required this.icon,
    super.key,
  });

  @override
  AnimatedSnackBarContentState createState() => AnimatedSnackBarContentState();
}

class AnimatedSnackBarContentState extends State<AnimatedSnackBarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller for entry and exit animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );

    // Create the slide animation
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0), // Starts above the screen
      end: Offset.zero, // Ends at the final position (visible)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Play the forward animation (show the SnackBar)
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        padding: paddingAllM,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(radiusM),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: Colors.white, size: iconM),
            horizontalSpaceS,
            Expanded(
              child: Text(
                widget.message,
                style: context.textTheme.titleSmall?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
