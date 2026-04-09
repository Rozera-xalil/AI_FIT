import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/lang_controller.dart';
import '../painters/grid_painter.dart'; // استيراد GridPainter
import '../widgets/common/card_widget.dart';
import '../widgets/profile/profile_header.dart';
import '../widgets/profile/profile_row.dart';
import 'auth_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(children: [
        // تصحيح: استخدم GridPainter() بدلاً من _GridPainter()
        CustomPaint(painter: GridPainter(), size: size),
        CustomScrollView(slivers: [
          // إزالة const من ProfileHeader() إذا لم يكن const constructor
          SliverToBoxAdapter(child: ProfileHeader()),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 16),
                CardWidget(child: GetBuilder<LangController>(
                  builder: (lang) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('app_settings'.tr,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 12, color: C.textMuted,
                              letterSpacing: 1, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),
                      ProfileRow(
                        icon: Icons.language_rounded,
                        label: 'language'.tr,
                        trailing: GestureDetector(
                          onTap: () => Get.bottomSheet(
                            const LangSheet(),
                            backgroundColor: C.bgCard,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24))),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: C.gradPrimary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(lang.currentLabel,
                                style: const TextStyle(
                                    fontFamily: 'Rajdhani',
                                    fontSize: 11, color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(height: 14),
                CardWidget(child: GetBuilder<LangController>(
                  builder: (_) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('account'.tr,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 12, color: C.textMuted,
                              letterSpacing: 1, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 14),
                      ProfileRow(icon: Icons.person_outline_rounded,
                          label: 'edit_profile'.tr),
                      ProfileRow(icon: Icons.notifications_none_rounded,
                          label: 'notifications'.tr),
                      ProfileRow(icon: Icons.lock_outline_rounded,
                          label: 'privacy'.tr),
                      ProfileRow(icon: Icons.info_outline_rounded,
                          label: 'about_app'.tr, showDivider: false),
                    ],
                  ),
                )),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: () => Get.offAll(() => const AuthScreen(),
                      transition: Transition.fadeIn),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: C.danger.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: C.danger.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded,
                            color: C.danger, size: 18),
                        const SizedBox(width: 8),
                        GetBuilder<LangController>(
                          builder: (_) => Text('logout'.tr,
                              style: const TextStyle(
                                  fontFamily: 'Rajdhani',
                                  fontSize: 15, fontWeight: FontWeight.w700,
                                  color: C.danger)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ]),
      ]),
    );
  }
}

class LangSheet extends StatelessWidget {
  const LangSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Get.find<LangController>();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 36, height: 4,
          decoration: BoxDecoration(
              color: C.border, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(height: 20),
        GetBuilder<LangController>(
          builder: (_) => Text('select_lang'.tr,
              style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 18, fontWeight: FontWeight.w700,
                  color: C.textPrim)),
        ),
        const SizedBox(height: 20),
        ...[
          ('en', '🇬🇧', 'English'),
          ('ku', '🌿', 'Kurdî (Kurmancî)'),
          ('fr', '🇫🇷', 'Français'),
        ].map((item) => GetBuilder<LangController>(
          builder: (l) {
            final active = l.currentCode == item.$1;
            return GestureDetector(
              onTap: () { lang.setLang(item.$1); Get.back(); },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: active
                      ? C.purple.withOpacity(0.15)
                      : C.bgSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: active
                        ? C.purple.withOpacity(0.5)
                        : C.border,
                    width: active ? 1.5 : 1),
                ),
                child: Row(children: [
                  active
                      ? const Icon(Icons.check_circle_rounded,
                          color: C.purple, size: 18)
                      : const SizedBox(width: 18),
                  const SizedBox(width: 12),
                  Text(item.$2, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Text(item.$3,
                      style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 16, fontWeight: FontWeight.w600,
                          color: active ? C.purple : C.textSec)),
                ]),
              ),
            );
          },
        )),
        const SizedBox(height: 8),
      ]),
    );
  }
}