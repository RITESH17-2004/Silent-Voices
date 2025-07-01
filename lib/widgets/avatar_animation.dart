import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AvatarAnimation extends StatelessWidget {
  const AvatarAnimation({super.key, this.size = 180});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        'assets/animations/sign_avatar.json', // Placeholder path
        repeat: true,
        fit: BoxFit.contain,
      ),
    );
  }
} 