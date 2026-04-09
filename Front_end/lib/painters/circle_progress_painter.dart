import 'dart:math';

import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CircleProgressPainter extends CustomPainter {
  final double progress;
  const CircleProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - 4;
    final rect = Rect.fromCircle(center: c, radius: r);

    canvas.drawCircle(c, r,
        Paint()
          ..color = C.border
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4);

    canvas.drawArc(rect, -pi / 2, 2 * pi * progress, false,
        Paint()
          ..shader = C.gradPrimary.createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(CircleProgressPainter o) => o.progress != progress;
}