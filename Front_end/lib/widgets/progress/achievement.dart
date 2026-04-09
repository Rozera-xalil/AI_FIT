import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class Achievement extends StatelessWidget {
  final String emoji, title, sub;
  final bool unlocked;
  const Achievement(
      {required this.emoji, required this.title,
      required this.sub, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: unlocked ? C.gold.withOpacity(0.07) : C.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: unlocked ? C.gold.withOpacity(0.25) : C.border),
      ),
      child: Column(children: [
        Text(unlocked ? emoji : '🔒',
            style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 5),
        Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 11, fontWeight: FontWeight.w700,
                color: unlocked ? C.gold : C.textMuted)),
        Text(sub,
            style: const TextStyle(
                fontFamily: 'Rajdhani', fontSize: 9, color: C.textSec)),
      ]),
    );
  }
}