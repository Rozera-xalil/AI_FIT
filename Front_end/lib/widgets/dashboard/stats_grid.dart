import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_recommenation_ai_sys/controllers/lang_controller.dart';
import '../../constants/colors.dart';

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LangController>(
      builder: (_) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12, mainAxisSpacing: 12,
        childAspectRatio: 1.55,
        children: [
          StatTile(value: '24', label: 'sessions'.tr,
              icon: Icons.fitness_center_rounded, color: C.purple),
          StatTile(value: '8.2K', label: 'calories'.tr,
              icon: Icons.local_fire_department_rounded,
              color: const Color(0xFFEF4444)),
          StatTile(value: '14', label: 'days'.tr,
              icon: Icons.calendar_today_rounded, color: C.success),
          StatTile(value: '73%', label: 'weekly_goal'.tr,
              icon: Icons.track_changes_rounded, color: C.gold),
        ],
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color;
  const StatTile(
      {required this.value, required this.label,
      required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: C.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: C.border),
      ),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 18, fontWeight: FontWeight.w700, color: color)),
            Text(label,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 9, color: C.textSec)),
          ]),
        ),
      ]),
    );
  }
}