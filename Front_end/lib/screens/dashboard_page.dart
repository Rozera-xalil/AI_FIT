import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/lang_controller.dart';
import '../controllers/tasks_controller.dart';
import '../painters/grid_painter.dart';
import '../painters/circle_progress_painter.dart';
import '../widgets/common/card_widget.dart';
import '../widgets/common/section_header.dart';
import '../widgets/dashboard/hero_card.dart';
import '../widgets/dashboard/task_mini_card.dart';
import '../widgets/dashboard/quick_card.dart';
import '../widgets/dashboard/stats_grid.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowCtrl;

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500))
      ..repeat(reverse: true);
  }

  @override
  void dispose() { _glowCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(children: [
        CustomPaint(painter: GridPainter(), size: size),
        CustomScrollView(slivers: [
          _AppBarSliver(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                HeroCard(glowCtrl: _glowCtrl),
                const SizedBox(height: 20),
                 UpcomingTasksWidget(),
                const SizedBox(height: 20),
                GetBuilder<LangController>(
                  builder: (_) => SectionHeader(
                      title: 'quick_start'.tr, action: ''),
                ),
                const SizedBox(height: 12),
                 QuickStartRow(),
                const SizedBox(height: 20),
                 WeeklyGoalCard(),
                const SizedBox(height: 20),
                GetBuilder<LangController>(
                  builder: (_) => SectionHeader(
                      title: 'your_stats'.tr, action: ''),
                ),
                const SizedBox(height: 12),
                 StatsGrid(),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _AppBarSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: C.bg,
      pinned: true,
      expandedHeight: 130,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: C.bgSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: C.border),
              ),
              child: Stack(alignment: Alignment.center, children: [
                const Icon(Icons.notifications_none_rounded,
                    color: C.textSec, size: 18),
                Positioned(
                  top: 6, right: 7,
                  child: Container(
                    width: 7, height: 7,
                    decoration: BoxDecoration(
                      color: C.gold, shape: BoxShape.circle,
                      boxShadow: [BoxShadow(
                          color: C.gold.withOpacity(0.5), blurRadius: 4)]),
                  ),
                ),
              ]),
            ),
            Flexible(
              child: GetBuilder<LangController>(
                builder: (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('hello_champ'.tr,
                        style: const TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: 10, color: C.textSec)),
                    Text('discover'.tr,
                        style: const TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: 13, fontWeight: FontWeight.w700,
                            color: C.textPrim)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: const [],
    );
  }
}

class WeeklyGoalCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShaderMask(
              shaderCallback: (b) => C.gradGold.createShader(b),
              child: const Text('73%',
                  style: TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 24, fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
            GetBuilder<LangController>(
              builder: (_) => Text('weekly_goal'.tr,
                  style: const TextStyle(
                      fontFamily: 'Rajdhani',
                      fontSize: 14, fontWeight: FontWeight.w700,
                      color: C.textPrim)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _GradBar(value: 0.73, colors: [C.gold, C.goldL]),
        const SizedBox(height: 8),
        const Text('5 / 7',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: 'Rajdhani', fontSize: 11, color: C.textSec)),
      ]),
    );
  }
}

class _GradBar extends StatelessWidget {
  final double value;
  final List<Color> colors;
  const _GradBar({required this.value, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: value,
        backgroundColor: C.border,
        valueColor: AlwaysStoppedAnimation(colors.first),
        minHeight: 7,
      ),
    );
  }
}

class QuickStartRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: GetBuilder<LangController>(
        builder: (_) => ListView(
          scrollDirection: Axis.horizontal,
          children: [
            QuickCard(emoji: '🔥', title: 'hiit'.tr,
                duration: '30 ${'mins'.tr}',
                color: const Color(0xFFEF4444)),
            QuickCard(emoji: '💪', title: 'strength'.tr,
                duration: '45 ${'mins'.tr}', color: C.purple),
            QuickCard(emoji: '🏃', title: 'cardio'.tr,
                duration: '40 ${'mins'.tr}', color: C.success),
            QuickCard(emoji: '🧘', title: 'yoga'.tr,
                duration: '35 ${'mins'.tr}', color: C.gold),
          ],
        ),
      ),
    );
  }
}