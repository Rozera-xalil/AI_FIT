import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../painters/spinner_painter.dart';

class SpinnerWidget extends StatelessWidget {
  const SpinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24, height: 24,
      child: CustomPaint(painter: SpinnerPainter(0.0)),
    );
  }
}