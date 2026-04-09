import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class StatBox extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color;
  const StatBox(
      {required this.value, required this.label,
      required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: C.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 20, fontWeight: FontWeight.w700, color: color)),
        Text(label,
            style: const TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 9, color: C.textSec)),
      ]),
    );
  }
}