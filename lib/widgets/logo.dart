import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.size = 80});
  final double size;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.pan_tool_alt_rounded,
        size: size * 0.6,
        color: const Color(0xFF2B4C6F),
      ),
    );
  }
} 