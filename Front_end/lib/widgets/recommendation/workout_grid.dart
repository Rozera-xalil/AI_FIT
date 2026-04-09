import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/lang_controller.dart';

class WorkoutGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LangController>(
      builder: (_) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12, mainAxisSpacing: 12,
        childAspectRatio: 1.05,
        children: [
          WorkoutTypeCard(emoji: '🔥', title: 'hiit'.tr,
              desc: 'hiit_desc'.tr, mins: '20-45',
              color: const Color(0xFFEF4444)),
          WorkoutTypeCard(emoji: '💪', title: 'strength'.tr,
              desc: 'strength_desc'.tr, mins: '45-60', color: C.purple),
          WorkoutTypeCard(emoji: '🏃', title: 'cardio'.tr,
              desc: 'cardio_desc'.tr, mins: '30-60', color: C.success),
          WorkoutTypeCard(emoji: '🧘', title: 'yoga'.tr,
              desc: 'yoga_desc'.tr, mins: '30-50', color: C.gold),
        ],
      ),
    );
  }
}

class WorkoutTypeCard extends StatelessWidget {
  final String emoji, title, desc, mins;
  final Color color;
  const WorkoutTypeCard(
      {required this.emoji, required this.title,
      required this.desc, required this.mins, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: C.bgCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('$mins min',
                  style: TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 9, color: color,
                      fontWeight: FontWeight.w700))),
            Text(emoji, style: const TextStyle(fontSize: 26)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(title,
                style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 16, fontWeight: FontWeight.w700, color: color)),
            Text(desc,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 10, color: C.textSec, height: 1.3)),
          ]),
        ],
      ),
    );
  }
}