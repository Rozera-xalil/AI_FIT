import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/lang_controller.dart';
import '../painters/grid_painter.dart';
import '../painters/spinner_painter.dart';
import '../widgets/common/logo_badge.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _spinCtrl;

  @override
  void initState() {
    super.initState();
    _logoCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..repeat(reverse: true);
    _spinCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000))
      ..repeat();

    _logoCtrl.forward();

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Get.off(() => const AuthScreen(),
            transition: Transition.fade,
            duration: const Duration(milliseconds: 600));
      }
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _glowCtrl.dispose();
    _spinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(children: [
        // تم التصحيح هنا: استخدم GridPainter() بدلاً من _GridPainter()
        CustomPaint(painter: GridPainter(), size: size),
        AnimatedBuilder(
          animation: _glowCtrl,
          builder: (_, __) => Stack(children: [
            Positioned(
              top: size.height * 0.1, left: size.width * 0.05,
              child: _GlowOrb(
                  color: C.purple, size: 280,
                  opacity: 0.18 * (_glowCtrl.value * 0.4 + 0.6)),
            ),
            Positioned(
              bottom: size.height * 0.12, right: size.width * 0.1,
              child: _GlowOrb(
                  color: C.gold, size: 200,
                  opacity: 0.14 * (_glowCtrl.value * 0.4 + 0.6)),
            ),
          ]),
        ),
        Center(
          child: AnimatedBuilder(
            animation: _spinCtrl,
            builder: (_, __) => Transform.rotate(
              angle: _spinCtrl.value * 2 * pi,
              child: Container(
                width: 160, height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: C.purple.withOpacity(0.15), width: 1),
                ),
                child: Stack(
                  children: List.generate(8, (i) {
                    final angle = i * pi / 4;
                    return Positioned(
                      left: 75 + cos(angle) * 72,
                      top: 75 + sin(angle) * 72,
                      child: Container(
                        width: 6, height: 6,
                        decoration: BoxDecoration(
                          color: i % 2 == 0
                              ? C.purple.withOpacity(0.6)
                              : C.gold.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: AnimatedBuilder(
            animation: _logoCtrl,
            builder: (_, __) {
              final val = CurvedAnimation(
                      parent: _logoCtrl, curve: Curves.elasticOut)
                  .value;
              return Transform.scale(
                scale: val.clamp(0.0, 1.0),
                child: Opacity(
                  opacity: Tween<double>(begin: 0, end: 1)
                      .animate(CurvedAnimation(
                          parent: _logoCtrl,
                          curve: const Interval(0.0, 0.4)))
                      .value,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AnimatedBuilder(
                      animation: _glowCtrl,
                      builder: (_, __) => Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(
                          gradient: C.gradPrimary,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: C.purple.withOpacity(
                                  0.5 * (_glowCtrl.value * 0.4 + 0.6)),
                              blurRadius: 40, spreadRadius: 8),
                          ],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('KRD',
                                style: TextStyle(
                                    fontFamily: 'Rajdhani',
                                    fontSize: 24, fontWeight: FontWeight.w700,
                                    color: Colors.white, letterSpacing: 4)),
                            Text('FIT',
                                style: TextStyle(
                                    fontFamily: 'Rajdhani',
                                    fontSize: 13, fontWeight: FontWeight.w400,
                                    color: Color(0xFFE9D5FF),
                                    letterSpacing: 5)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    ShaderMask(
                      shaderCallback: (b) => C.gradPrimary.createShader(b),
                      child: const Text('KRD FIT',
                          style: TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 42, fontWeight: FontWeight.w700,
                              color: Colors.white, letterSpacing: 6)),
                    ),
                    const SizedBox(height: 8),
                    GetBuilder<LangController>(
                      builder: (lang) => Text(
                        'app_slogan'.tr,
                        style: const TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: 14, color: C.textSec,
                            letterSpacing: 1.5),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'app_tagline'.tr,
                      style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 12,
                          color: C.gold.withOpacity(0.8),
                          letterSpacing: 1),
                    ),
                    const SizedBox(height: 60),
                    const _KrdSpinner(),
                  ]),
                ),
              );
            },
          ),
        ),
        const Positioned(
          bottom: 32, left: 0, right: 0,
          child: Center(
            child: Text('v1.0.0  •  EN / KU / FR',
                style: TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 11, color: C.textMuted, letterSpacing: 2)),
          ),
        ),
      ]),
    );
  }
}

class _KrdSpinner extends StatefulWidget {
  const _KrdSpinner();
  @override
  State<_KrdSpinner> createState() => _KrdSpinnerState();
}

class _KrdSpinnerState extends State<_KrdSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400))
      ..repeat();
  }
  @override
  void dispose() { _c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => SizedBox(
        width: 44, height: 44,
        // تم التصحيح هنا: استخدم SpinnerPainter() بدلاً من _SpinnerPainter()
        child: CustomPaint(painter: SpinnerPainter(_c.value)),
      ),
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