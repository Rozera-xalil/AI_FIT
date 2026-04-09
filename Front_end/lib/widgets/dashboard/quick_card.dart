import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';

class QuickCard extends StatelessWidget {
  final String emoji, title, duration;
  final Color color;
  const QuickCard(
      {required this.emoji, required this.title,
      required this.duration, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: C.bgCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(title,
                style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 15, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 2),
            Text(duration,
                style: const TextStyle(
                    fontFamily: 'Rajdhani', fontSize: 11, color: C.textSec)),
          ]),
        ],
      ),
    );
  }
}