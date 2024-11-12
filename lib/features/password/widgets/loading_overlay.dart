import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (kIsWeb)
                  const CircularProgressIndicator.adaptive()
                else
                  Lottie.asset(
                    'assets/jsons/loading_lotie.json',
                    width: 100,
                    height: 100,
                  ),
                const SizedBox(height: 16),
                const Text('Processing...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
