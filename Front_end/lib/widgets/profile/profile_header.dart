import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/lang_controller.dart';
import 'profile_stat.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20,
          bottom: 24, left: 20, right: 20),
      decoration: const BoxDecoration(gradient: C.gradHero),
      child: Column(children: [
        Stack(alignment: Alignment.bottomRight, children: [
          Container(
            width: 88, height: 88,
            decoration: BoxDecoration(
              gradient: C.gradPrimary,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(color: C.purple.withOpacity(0.4),
                    blurRadius: 20, spreadRadius: 2),
              ],
            ),
            child: const Icon(Icons.person_rounded,
                color: Colors.white, size: 48),
          ),
          Container(
            width: 26, height: 26,
            decoration: BoxDecoration(
              gradient: C.gradGold,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(
                  color: C.gold.withOpacity(0.4), blurRadius: 8)],
            ),
            child: const Icon(Icons.edit_rounded,
                color: Colors.white, size: 14),
          ),
        ]),
        const SizedBox(height: 14),
        const Text('Aras Karîm',
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 22, fontWeight: FontWeight.w700,
                color: C.textPrim)),
        const SizedBox(height: 3),
        const Text('aras@email.com',
            style: TextStyle(
                fontFamily: 'Rajdhani', fontSize: 13, color: C.textSec)),
        const SizedBox(height: 8),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            gradient: C.gradGold,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(
                color: C.gold.withOpacity(0.3), blurRadius: 8)],
          ),
          child: GetBuilder<LangController>(
            builder: (_) => Text('🏆  ${'advanced'.tr}',
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 12, color: Colors.white,
                    fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(height: 20),
        GetBuilder<LangController>(
          builder: (_) => Row(children: [
            Expanded(child: ProfileStat(
                value: '24', label: 'sessions'.tr)),
             VertLine(),
            Expanded(child: ProfileStat(
                value: '8.2K', label: 'calories'.tr)),
             VertLine(),
            Expanded(child: ProfileStat(
                value: '14', label: 'days'.tr)),
          ]),
        ),
      ]),
    );
  }
}

class VertLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 32, color: C.border);
}