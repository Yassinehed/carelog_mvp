import 'package:flutter/material.dart';

/// Simple vector logo for CareLog: stylized 'C' with a check/flow mark inside.
class CareLogLogo extends StatelessWidget {
  final double size;
  final Color primaryColor;
  final Color accentColor;

  const CareLogLogo({
    super.key,
    this.size = 96,
    this.primaryColor = const Color(0xFF0A66C2), // primaryBlue
    this.accentColor = const Color(0xFFFF8A00), // accentOrange
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CareLogLogoPainter(primaryColor, accentColor),
      ),
    );
  }
}

class _CareLogLogoPainter extends CustomPainter {
  final Color primary;
  final Color accent;

  _CareLogLogoPainter(this.primary, this.accent);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = size.width * 0.36;

    // Draw stylized 'C' arc
    const startAngle = -3.14 / 2 - 0.2;
    const sweepAngle = 3.14 * 1.4;
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    // Draw check/flow mark using accent color
    final checkPaint = Paint()
      ..color = accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final p1 = Offset(cx - radius * 0.2, cy + radius * 0.05);
    final p2 = Offset(cx, cy + radius * 0.45);
    final p3 = Offset(cx + radius * 0.6, cy - radius * 0.35);

    final path = Path();
    path.moveTo(p1.dx, p1.dy);
    path.lineTo(p2.dx, p2.dy);
    path.lineTo(p3.dx, p3.dy);

    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
