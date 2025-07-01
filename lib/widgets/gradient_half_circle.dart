import 'package:flutter/material.dart';

class GradientHalfCircle extends StatelessWidget {
  final double diameter;
  const GradientHalfCircle({super.key, this.diameter = 260});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: diameter * 1.1,
      height: diameter / 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main half-circle with radial gradient and shadow
          Positioned(
            top: -diameter * 0.18,
            right: -diameter * 0.08,
            child: CustomPaint(
              size: Size(diameter, diameter),
              painter: _RadialHalfCirclePainter(),
            ),
          ),
          // Smaller, semi-transparent overlapping circle
          Positioned(
            top: diameter * 0.05,
            right: diameter * 0.18,
            child: Container(
              width: diameter * 0.45,
              height: diameter * 0.45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFBDB3A3).withOpacity(0.25), // Silver Pink
                    const Color(0xFF607EA2).withOpacity(0.10), // Rackley
                    Colors.transparent,
                  ],
                  center: Alignment(-0.3, -0.3),
                  radius: 0.9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadialHalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width, 0),
      radius: size.width,
    );
    final Gradient gradient = RadialGradient(
      colors: [
        const Color(0xFF607EA2), // Rackley
        const Color(0xFF8197AC), // Weldon Blue
        const Color(0xFFBDB3A3), // Silver Pink
      ],
      center: Alignment(0.7, -0.7),
      radius: 1.1,
    );
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 18);
    final Path path = Path()
      ..moveTo(size.width, 0)
      ..arcTo(rect, -1.5708, 3.1416, false)
      ..close();
    // Draw shadow
    canvas.saveLayer(null, Paint());
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 