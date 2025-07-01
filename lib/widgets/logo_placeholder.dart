import 'package:flutter/material.dart';

class LogoPlaceholder extends StatelessWidget {
  const LogoPlaceholder({super.key, this.size = 80});
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: const Color(0xFF90CAF9),
      child: Icon(
        Icons.pan_tool_alt_rounded,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }
} 