import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/lang_controller.dart';
import '../painters/grid_painter.dart';
import '../widgets/common/card_widget.dart';
import '../widgets/progress/stat_box.dart';
import '../widgets/progress/goal_bar.dart';
import '../widgets/progress/achievement.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});
  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _barCtrl;
  int _period = 0;
  static const _data = [0.4, 0.75, 0.5, 0.9, 0.6, 0.85, 0.3];
  static const _days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  void initState() {
    super.initState();
    _barCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..forward();
  }

  @override
  void dispose() { _barCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(children: [
        // تم التصحيح هنا: استخدم GridPainter() بدلاً من _GridPainter()
        CustomPaint(painter: GridPainter(), size: size),
        CustomScrollView(slivers: [
          GetBuilder<LangController>(
            builder: (_) => _PageAppBar(title: 'my_progress'.tr),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                GetBuilder<LangController>(
                  builder: (_) => Row(children: [
                    Expanded(child: StatBox(value: '24', label: 'sessions'.tr,
                        icon: Icons.fitness_center_rounded, color: C.purple)),
                    const SizedBox(width: 12),
                    Expanded(child: StatBox(value: '8.2K', label: 'calories'.tr,
                        icon: Icons.local_fire_department_rounded,
                        color: const Color(0xFFEF4444))),
                    const SizedBox(width: 12),
                    Expanded(child: StatBox(value: '14', label: 'days'.tr,
                        icon: Icons.calendar_today_rounded, color: C.success)),
                  ]),
                ),
                const SizedBox(height: 20),
                CardWidget(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<LangController>(
                          builder: (_) => _PillBtn(
                            label: _period == 1
                                ? 'this_month'.tr
                                : 'this_week'.tr,
                            active: true,
                            onTap: () => setState(() {
                              _period = _period == 0 ? 1 : 0;
                              _barCtrl.forward(from: 0);
                            })),
                        ),
                        const Text('Activity',
                            style: TextStyle(
                                fontFamily: 'Rajdhani',
                                fontSize: 14, fontWeight: FontWeight.w700,
                                color: C.textPrim)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _barCtrl,
                      builder: (_, __) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(7, (i) {
                          final h = 100.0 *
                              _data[i] *
                              CurvedAnimation(
                                      parent: _barCtrl,
                                      curve: Curves.easeOut)
                                  .value;
                          final isMax = _data[i] ==
                              _data.reduce((a, b) => a > b ? a : b);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 26, height: h,
                                decoration: BoxDecoration(
                                  gradient: isMax ? C.gradPrimary : null,
                                  color: isMax ? null : C.bgSurface,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: isMax
                                      ? [BoxShadow(
                                          color: C.purple.withOpacity(0.4),
                                          blurRadius: 10,
                                          offset: const Offset(0, -2))]
                                      : [],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(_days[i],
                                  style: TextStyle(
                                      fontFamily: 'Rajdhani',
                                      fontSize: 10,
                                      color: isMax ? C.purple : C.textMuted,
                                      fontWeight: isMax
                                          ? FontWeight.w700
                                          : FontWeight.w400)),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                CardWidget(child: GetBuilder<LangController>(
                  builder: (_) => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('goals'.tr,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 14, fontWeight: FontWeight.w700,
                              color: C.textPrim)),
                      const SizedBox(height: 16),
                      const GoalBar(label: 'Workout Sessions',
                          val: 5, max: 7, color: C.purple),
                      const SizedBox(height: 12),
                      const GoalBar(label: 'Calories Burned',
                          val: 2400, max: 3500, color: C.gold),
                      const SizedBox(height: 12),
                      const GoalBar(label: 'Water Intake',
                          val: 12, max: 14, color: C.success),
                      const SizedBox(height: 12),
                      const GoalBar(label: 'Sleep Hours',
                          val: 6, max: 8,
                          color: Color(0xFF3B82F6)),
                    ],
                  ),
                )),
                const SizedBox(height: 20),
                GetBuilder<LangController>(
                  builder: (_) =>
                      _SectionHeader(title: 'achievements'.tr, action: ''),
                ),
                const SizedBox(height: 12),
                GetBuilder<LangController>(
                  builder: (_) => Row(children: [
                    Expanded(child: Achievement(
                        emoji: '🏆', title: 'streak'.tr,
                        sub: 'streak_days'.tr, unlocked: true)),
                    const SizedBox(width: 10),
                    Expanded(child: Achievement(
                        emoji: '🔥', title: 'cal_burned'.tr,
                        sub: 'burned'.tr, unlocked: true)),
                    const SizedBox(width: 10),
                    Expanded(child: Achievement(
                        emoji: '💎', title: 'goal_30'.tr,
                        sub: 'locked'.tr, unlocked: false)),
                  ]),
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

class _PageAppBar extends StatelessWidget {
  final String title;
  const _PageAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: C.bg,
      pinned: true, elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: C.bgSurface, borderRadius: BorderRadius.circular(10),
              border: Border.all(color: C.border)),
            child: const Icon(Icons.more_horiz_rounded,
                color: C.textSec, size: 16),
          ),
          ShaderMask(
            shaderCallback: (b) => C.gradPrimary.createShader(b),
            child: Text(title,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 18, fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              gradient: C.gradPrimary,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(
                  color: C.purple.withOpacity(0.4),
                  blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('KRD',
                    style: TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 7, fontWeight: FontWeight.w700,
                        color: Colors.white, letterSpacing: 1)),
                Text('FIT',
                    style: TextStyle(
                        fontFamily: 'Rajdhani',
                        fontSize: 4, fontWeight: FontWeight.w400,
                        color: Color(0xFFE9D5FF),
                        letterSpacing: 1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PillBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _PillBtn(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          gradient: active ? C.gradPrimary : null,
          color: active ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: active ? null : Border.all(color: C.border),
        ),
        child: Text(label,
            style: TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 12, fontWeight: FontWeight.w600,
                color: active ? Colors.white : C.textSec)),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title, action;
  const _SectionHeader({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (action.isNotEmpty)
          ShaderMask(
            shaderCallback: (b) => C.gradPrimary.createShader(b),
            child: Text(action,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 13, fontWeight: FontWeight.w700,
                    color: Colors.white))),
        Text(title,
            style: const TextStyle(
                fontFamily: 'Rajdhani',
                fontSize: 16, fontWeight: FontWeight.w700,
                color: C.textPrim, letterSpacing: -0.2)),
      ],
    );
  }
}