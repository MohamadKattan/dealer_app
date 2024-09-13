import 'package:flutter/material.dart';

class DotDivider extends StatelessWidget {
  final double height;
  final double dotRadius;
  final Color dotColor;
  final double spacing;

  const DotDivider({
    super.key,
    this.height = 1.0,
    this.dotRadius = 2.0,
    this.dotColor = Colors.black,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _DotPainter(
        dotRadius: dotRadius,
        dotColor: dotColor,
        spacing: spacing,
      ),
    );
  }
}

class _DotPainter extends CustomPainter {
  final double dotRadius;
  final Color dotColor;
  final double spacing;

  _DotPainter({
    required this.dotRadius,
    required this.dotColor,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..strokeWidth = dotRadius * 2;

    double x = dotRadius;
    while (x < size.width) {
      canvas.drawCircle(Offset(x, size.height / 2), dotRadius, paint);
      x += dotRadius * 2 + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
