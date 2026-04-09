import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class GoalBar extends StatelessWidget {
  final String label;
  final double val, max;
  final Color color;
  const GoalBar(
      {required this.label, required this.val,
      required this.max, required this.color});

  @override
  Widget build(BuildContext context) {
    final pct = (val / max).clamp(0.0, 1.0);
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('${(pct * 100).toStringAsFixed(0)}%',
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 11, color: color, fontWeight: FontWeight.w700)),
        Text(label,
            style: const TextStyle(
                fontFamily: 'Rajdhani', fontSize: 12, color: C.textSec)),
      ]),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: LinearProgressIndicator(
          value: pct,
          backgroundColor: C.border,
          valueColor: AlwaysStoppedAnimation(color),
          minHeight: 5,
        ),
      ),
    ]);
  }
}