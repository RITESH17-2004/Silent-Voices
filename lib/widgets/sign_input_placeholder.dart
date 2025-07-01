import 'package:flutter/material.dart';

class SignInputPlaceholder extends StatelessWidget {
  final VoidCallback? onPressed;
  const SignInputPlaceholder({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.pan_tool_alt_rounded),
      label: const Text('Record Sign'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 48),
      ),
    );
  }
} 