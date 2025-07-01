import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedWavyBackground extends StatefulWidget {
  final double height;
  const AnimatedWavyBackground({super.key, this.height = 120});

  @override
  State<AnimatedWavyBackground> createState() => _AnimatedWavyBackgroundState();
}

class _AnimatedWavyBackgroundState extends State<AnimatedWavyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _AnimatedWavyPainter(
              progress: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedWavyPainter extends CustomPainter {
  final double progress;
  _AnimatedWavyPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF607EA2), // Rackley
          const Color(0xFF8197AC), // Weldon Blue
          const Color(0xFFBDB3A3), // Silver Pink
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    double waveHeight = size.height * 0.25;
    double waveLength = size.width * 1.2;
    double shift = progress * 2 * pi;

    path.moveTo(0, size.height * 0.4);
    for (double x = 0; x <= size.width; x += 1) {
      double y = size.height * 0.6 +
          sin((x / waveLength * 2 * pi) + shift) * waveHeight;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AnimatedWavyPainter oldDelegate) => true;
} 