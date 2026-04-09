import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/lang_controller.dart';
import '../controllers/tasks_controller.dart';
import '../painters/grid_painter.dart';
import '../widgets/tasks/task_card.dart';
import '../widgets/tasks/add_task_fab.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TasksController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(children: [
        CustomPaint(painter: GridPainter(), size: size),
        CustomScrollView(slivers: [
          GetBuilder<LangController>(
            builder: (_) => _PageAppBar(title: 'nav_tasks'.tr),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            sliver: Obx(() {
              if (ctrl.tasks.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          color: C.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(Icons.fitness_center_rounded,
                            color: C.purple, size: 40),
                      ),
                      const SizedBox(height: 16),
                      GetBuilder<LangController>(
                        builder: (_) => Text('no_tasks'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Rajdhani',
                                fontSize: 15, color: C.textSec,
                                height: 1.5)),
                      ),
                    ]),
                  ),
                );
              }
              final upcoming = ctrl.upcoming;
              final past = ctrl.past;
              return SliverList(
                delegate: SliverChildListDelegate([
                  if (upcoming.isNotEmpty) ...[
                    _TaskSectionLabel('Upcoming — ${upcoming.length}'),
                    const SizedBox(height: 8),
                    ...upcoming.map((t) => TaskCard(task: t)),
                    const SizedBox(height: 16),
                  ],
                  if (past.isNotEmpty) ...[
                    _TaskSectionLabel('Completed / Past — ${past.length}'),
                    const SizedBox(height: 8),
                    ...past.map((t) => TaskCard(task: t)),
                  ],
                ]),
              );
            }),
          ),
        ]),
      ]),
      floatingActionButton:  AddTaskFAB(),
    );
  }
}

class _TaskSectionLabel extends StatelessWidget {
  final String text;
  const _TaskSectionLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontFamily: 'Rajdhani',
            fontSize: 12, color: C.textMuted,
            fontWeight: FontWeight.w600, letterSpacing: 1));
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