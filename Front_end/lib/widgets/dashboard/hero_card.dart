import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/lang_controller.dart';
import '../../painters/circle_progress_painter.dart';

class HeroCard extends StatelessWidget {
  final AnimationController glowCtrl;
  const HeroCard({required this.glowCtrl});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowCtrl,
      builder: (_, __) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFF1A1236), Color(0xFF110E22)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
              color: C.purple.withOpacity(
                  0.35 * (glowCtrl.value * 0.4 + 0.6))),
          boxShadow: [
            BoxShadow(
                color: C.purple.withOpacity(0.18 * glowCtrl.value),
                blurRadius: 30, spreadRadius: 2),
          ],
        ),
        child: Column(children: [
          Row(children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Rojevên Vê Hefteyê',
                      style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 11, color: C.textSec)),
                  const SizedBox(height: 4),
                  ShaderMask(
                    shaderCallback: (b) => C.gradPrimary.createShader(b),
                    child: const Text('5 / 7',
                        style: TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: 40, fontWeight: FontWeight.w700,
                            color: Colors.white, letterSpacing: -1)),
                  ),
                  GetBuilder<LangController>(
                    builder: (_) => Text('sessions'.tr,
                        style: const TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: 12, color: C.textSec)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 82, height: 82,
              child: CustomPaint(
                painter: CircleProgressPainter(progress: 0.71),
                child: Center(
                  child: Text('71%',
                      style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 16, fontWeight: FontWeight.w700,
                          color: C.purple,
                          shadows: [Shadow(
                              color: C.purple.withOpacity(0.4),
                              blurRadius: 8)])),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeroChip(value: '1,680', label: 'kal', color: C.gold),
              HeroChip(value: '2.4L', label: 'av', color: C.purpleL),
              HeroChip(value: '7h 30', label: 'xew', color: C.success),
            ],
          ),
        ]),
      ),
    );
  }
}

class HeroChip extends StatelessWidget {
  final String value, label;
  final Color color;
  const HeroChip(
      {required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(children: [
        Text(value,
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 15, fontWeight: FontWeight.w700, color: color)),
        Text(label,
            style: const TextStyle(
                fontFamily: 'Rajdhani', fontSize: 9, color: C.textSec)),
      ]),
    );
  }
}