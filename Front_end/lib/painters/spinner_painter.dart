import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class SpinnerPainter extends CustomPainter {
  final double progress;
  SpinnerPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 3;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawCircle(center, radius,
        Paint()
          ..color = C.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);

    canvas.drawArc(rect, progress * 2 * pi - pi / 2, pi * 1.2, false,
        Paint()
          ..shader =
              const LinearGradient(colors: [C.purple, C.purpleL]).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round);

    canvas.drawArc(rect, (progress + 0.5) * 2 * pi - pi / 2, pi * 0.6, false,
        Paint()
          ..shader =
              const LinearGradient(colors: [C.gold, C.goldL]).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(SpinnerPainter old) => old.progress != progress;
}