import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_recommenation_ai_sys/screens/profile_page.dart';
import '../constants/colors.dart';
import '../controllers/lang_controller.dart';
import '../painters/grid_painter.dart';
import '../widgets/auth/auth_tab.dart';
import '../widgets/auth/social_button.dart';import '../widgets/common/field_widget.dart';
import '../widgets/common/primary_button.dart';
import '../widgets/common/logo_badge.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  bool _loading = false;
  bool _passVis = false;
  late AnimationController _glowCtrl;

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    setState(() => _loading = false);
    Get.off(() => const HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500));
  }

  void _showLangSheet() {
    Get.bottomSheet(
      const LangSheet(),
      backgroundColor: C.bgCard,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(children: [
        CustomPaint(painter: GridPainter(), size: size),
        AnimatedBuilder(
          animation: _glowCtrl,
          builder: (_, __) => Stack(children: [
            Positioned(
              top: -100, right: -60,
              child: _GlowOrb(
                  color: C.purple, size: 320,
                  opacity: 0.14 * (_glowCtrl.value * 0.4 + 0.6)),
            ),
            Positioned(
              bottom: -80, left: -80,
              child: _GlowOrb(
                  color: C.gold, size: 240,
                  opacity: 0.10 * (_glowCtrl.value * 0.4 + 0.6)),
            ),
          ]),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),
                Row(children: [
                  const LogoBadge(size: 46),
                  const SizedBox(width: 12),
                  Flexible(
                    child: ShaderMask(
                      shaderCallback: (b) => C.gradPrimary.createShader(b),
                      child: GetBuilder<LangController>(
                        builder: (_) => Text('app_name'.tr,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 22, fontWeight: FontWeight.w700,
                              color: Colors.white, letterSpacing: 3)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GetBuilder<LangController>(
                    builder: (lang) => GestureDetector(
                      onTap: () => _showLangSheet(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: C.bgSurface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: C.border),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          const Icon(Icons.language_rounded,
                              color: C.textSec, size: 14),
                          const SizedBox(width: 5),
                          Text(lang.currentLabel,
                              style: const TextStyle(
                                  fontFamily: 'Rajdhani',
                                  fontSize: 12, color: C.textSec)),
                        ]),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 44),
                GetBuilder<LangController>(
                  builder: (_) => Text(
                    _isLogin ? 'welcome_back'.tr : 'join_us'.tr,
                    style: const TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 36, fontWeight: FontWeight.w700,
                        color: C.textPrim, height: 1.2),
                  ),
                ),
                const SizedBox(height: 6),
                GetBuilder<LangController>(
                  builder: (_) => Text(
                    _isLogin ? 'login_sub'.tr : 'reg_sub'.tr,
                    style: const TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 15, color: C.textSec),
                  ),
                ),
                const SizedBox(height: 36),
                Container(
                  height: 52,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: C.bgSurface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: C.border),
                  ),
                  child: Row(children: [
                    GetBuilder<LangController>(
                      builder: (_) => AuthTab(
                          label: 'login'.tr,
                          active: _isLogin,
                          onTap: () => setState(() => _isLogin = true)),
                    ),
                    GetBuilder<LangController>(
                      builder: (_) => AuthTab(
                          label: 'register'.tr,
                          active: !_isLogin,
                          onTap: () => setState(() => _isLogin = false)),
                    ),
                  ]),
                ),
                const SizedBox(height: 28),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: GetBuilder<LangController>(
                    builder: (_) => Column(children: [
                      if (!_isLogin) ...[
                        FieldWidget(
                            ctrl: _nameCtrl,
                            hint: 'full_name'.tr,
                            icon: Icons.person_outline_rounded),
                        const SizedBox(height: 14),
                      ],
                      FieldWidget(
                          ctrl: _emailCtrl,
                          hint: 'email'.tr,
                          icon: Icons.mail_outline_rounded,
                          type: TextInputType.emailAddress),
                      const SizedBox(height: 14),
                      FieldWidget(
                        ctrl: _passCtrl,
                        hint: 'password'.tr,
                        icon: Icons.lock_outline_rounded,
                        obscure: !_passVis,
                        suffix: IconButton(
                          icon: Icon(
                              _passVis
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: C.textSec, size: 20),
                          onPressed: () =>
                              setState(() => _passVis = !_passVis),
                        ),
                      ),
                    ]),
                  ),
                ),
                if (_isLogin) ...[
                  const SizedBox(height: 12),
                  GetBuilder<LangController>(
                    builder: (_) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text('forgot_pass'.tr,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 13, color: C.gold,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                PrimaryButton(
                  loading: _loading,
                  onTap: _loading ? null : _submit,
                  child: GetBuilder<LangController>(
                    builder: (_) => Text(
                      _isLogin ? 'enter'.tr : 'create_acc'.tr,
                      style: const TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 17, fontWeight: FontWeight.w700,
                          color: Colors.white, letterSpacing: 0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(children: [
                  const Expanded(child: Divider(color: C.border)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GetBuilder<LangController>(
                      builder: (_) => Text('or'.tr,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              color: C.textMuted, fontSize: 13)),
                    ),
                  ),
                  const Expanded(child: Divider(color: C.border)),
                ]),
                const SizedBox(height: 20),
                SocialButton(onTap: _submit),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size, opacity;
  const _GlowOrb(
      {required this.color, required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
            colors: [color.withOpacity(opacity), Colors.transparent]),
      ),
    );
  }
}