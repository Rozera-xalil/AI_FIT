import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/lang_controller.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, height: 52,
        decoration: BoxDecoration(
          color: C.bgSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: C.border),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.g_mobiledata_rounded, color: C.textPrim, size: 28),
          const SizedBox(width: 10),
          GetBuilder<LangController>(
            builder: (_) => Text('with_google'.tr,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 14, fontWeight: FontWeight.w600,
                    color: C.textPrim)),
          ),
        ]),
      ),
    );
  }
}