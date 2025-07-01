import 'package:flutter/material.dart';

class SpeechInputButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const SpeechInputButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.mic, size: 36, color: Color(0xFF90CAF9)),
      onPressed: onPressed,
      tooltip: 'Speak',
      iconSize: 48,
    );
  }
} 