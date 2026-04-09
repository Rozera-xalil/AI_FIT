import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_recommenation_ai_sys/widgets/common/section_header.dart';
import '../../constants/colors.dart';
import '../../controllers/tasks_controller.dart';
import '../../models/workout_task.dart';

class UpcomingTasksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TasksController>();
    return Obx(() {
      final upcoming = ctrl.upcoming.take(2).toList();
      if (upcoming.isEmpty) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SectionHeader(title: 'my_tasks'.tr, action: ''),
          const SizedBox(height: 12),
          ...upcoming.map((t) => TaskMiniCard(task: t)),
          const SizedBox(height: 8),
        ],
      );
    });
  }
}

class TaskMiniCard extends StatelessWidget {
  final WorkoutTask task;
  const TaskMiniCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final diff = task.scheduledAt.difference(now);
    final isClose = diff.inMinutes <= 30 && diff.inMinutes > 0;
    final emoji = _emojiFor(task.workoutType);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isClose ? C.gold.withOpacity(0.08) : C.bgCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: isClose ? C.gold.withOpacity(0.4) : C.border),
      ),
      child: Row(children: [
        if (isClose)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: C.gold.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('${diff.inMinutes}m',
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 11, color: C.gold,
                    fontWeight: FontWeight.w700)))
        else
          Text('HH:mm', // Would use intl package in real app
              style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 12, color: C.textSec)),
        const Spacer(),
        Flexible(
          child: Text(task.name,
              style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 14, fontWeight: FontWeight.w700,
                  color: C.textPrim)),
        ),
        const SizedBox(width: 10),
        Text(emoji, style: const TextStyle(fontSize: 22)),
      ]),
    );
  }

  String _emojiFor(String type) {
    if (type.contains('HIIT')) return '🔥';
    if (type.contains('Hêz') ||
        type.contains('Strength') ||
        type.contains('Force')) return '💪';
    if (type.contains('Kardîyo') || type.contains('Cardio')) return '🏃';
    return '🧘';
  }
}