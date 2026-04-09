import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/recom_controller.dart';

class LevelButton extends StatelessWidget {
  final String label;
  final int val;
  const LevelButton({required this.label, required this.val});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<RecomController>();
    return Obx(() {
      final active = ctrl.experience.value == val;
      return Expanded(
        child: GestureDetector(
          onTap: () => ctrl.experience.value = val,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(
              gradient: active ? C.gradGold : null,
              color: active ? null : C.bgSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: active ? Colors.transparent : C.border),
              boxShadow: active
                  ? [BoxShadow(
                      color: C.gold.withOpacity(0.3), blurRadius: 10)]
                  : [],
            ),
            child: Center(
              child: Text(label,
                  style: TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 11, fontWeight: FontWeight.w700,
                      color: active ? Colors.white : C.textSec)),
            ),
          ),
        ),
      );
    });
  }
}