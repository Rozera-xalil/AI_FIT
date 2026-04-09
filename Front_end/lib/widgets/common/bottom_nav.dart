import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/lang_controller.dart';
import '../../controllers/tasks_controller.dart';

class BottomNav extends StatelessWidget {
  final int current;
  final Function(int) onTap;
  const BottomNav({required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: const Color(0xFF08061A),
        border: const Border(top: BorderSide(color: C.border, width: 0.5)),
        boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20, offset: const Offset(0, -4))],
      ),
      child: GetBuilder<LangController>(
        builder: (_) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBtn(icon: Icons.home_rounded, label: 'nav_home'.tr,
                idx: 0, current: current, onTap: onTap),
            _NavBtn(icon: Icons.bolt_rounded, label: 'nav_workout'.tr,
                idx: 1, current: current, onTap: onTap),
            _NavBtn(icon: Icons.check_circle_outline_rounded,
                label: 'nav_tasks'.tr,
                idx: 2, current: current, onTap: onTap, badge: true),
            _NavBtn(icon: Icons.trending_up_rounded,
                label: 'nav_progress'.tr,
                idx: 3, current: current, onTap: onTap),
            _NavBtn(icon: Icons.person_rounded, label: 'nav_profile'.tr,
                idx: 4, current: current, onTap: onTap),
          ],
        ),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final int idx, current;
  final Function(int) onTap;
  final bool badge;
  const _NavBtn(
      {required this.icon, required this.label,
      required this.idx, required this.current, required this.onTap,
      this.badge = false});

  @override
  Widget build(BuildContext context) {
    final active = idx == current;
    return GestureDetector(
      onTap: () => onTap(idx),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(clipBehavior: Clip.none, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                gradient: active ? C.gradPrimary : null,
                color: active ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                boxShadow: active
                    ? [BoxShadow(
                        color: C.purple.withOpacity(0.3), blurRadius: 8)]
                    : [],
              ),
              child: Icon(icon,
                  color: active ? Colors.white : C.textMuted, size: 21),
            ),
            if (badge)
              Obx(() {
                final cnt = Get.find<TasksController>().upcoming.length;
                if (cnt == 0) return const SizedBox.shrink();
                return Positioned(
                  top: -2, right: -2,
                  child: Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(
                      gradient: C.gradGold,
                      shape: BoxShape.circle,
                      border: Border.all(color: C.bg, width: 1.5)),
                    child: Center(
                      child: Text('$cnt',
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 8, color: Colors.white,
                              fontWeight: FontWeight.w700))),
                  ),
                );
              }),
          ]),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 9, fontWeight: FontWeight.w600,
                  color: active ? C.purple : C.textMuted)),
        ]),
      ),
    );
  }
}