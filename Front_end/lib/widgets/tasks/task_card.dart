import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/tasks_controller.dart';
import '../../models/workout_task.dart';

class TaskCard extends StatelessWidget {
  final WorkoutTask task;
  const TaskCard({required this.task});

  String _emojiFor(String t) {
    if (t.contains('HIIT')) return '🔥';
    if (t.contains('Hêz') || t.contains('Strength') || t.contains('Force')) return '💪';
    if (t.contains('Kardîyo') || t.contains('Cardio')) return '🏃';
    return '🧘';
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<TasksController>();
    final now = DateTime.now();
    final diff = task.scheduledAt.difference(now);
    final isClose = !task.isDone && diff.inMinutes <= 30 && diff.inMinutes > 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: task.isDone
            ? C.bgCard.withOpacity(0.5)
            : isClose ? C.gold.withOpacity(0.06) : C.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: task.isDone
              ? C.border.withOpacity(0.5)
              : isClose ? C.gold.withOpacity(0.4) : C.border),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => ctrl.toggleDone(task.id),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              GestureDetector(
                onTap: () => ctrl.deleteTask(task.id),
                child: Container(
                  width: 30, height: 30,
                  decoration: BoxDecoration(
                    color: C.danger.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.delete_outline_rounded,
                      color: C.danger, size: 16),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Row(children: [
                    if (isClose)
                      Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: C.gold.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('⚡ ${diff.inMinutes}m',
                            style: const TextStyle(
                                fontFamily: 'Rajdhani',
                                fontSize: 10, color: C.gold,
                                fontWeight: FontWeight.w700))),
                    Flexible(
                      child: Text(task.name,
                          style: TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 15, fontWeight: FontWeight.w700,
                              color: task.isDone ? C.textMuted : C.textPrim,
                              decoration: task.isDone
                                  ? TextDecoration.lineThrough
                                  : null)),
                    ),
                  ]),
                  const SizedBox(height: 3),
                  Row(children: [
                    Text(
                        'EEE, MMM d  HH:mm', // Would use intl in real app
                        style: const TextStyle(
                            fontFamily: 'Rajdhani',
                            fontSize: 11, color: C.textSec)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: C.purple.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(task.workoutType,
                          style: const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 9, color: C.purpleL,
                              fontWeight: FontWeight.w600))),
                  ]),
                ]),
              ),
              const SizedBox(width: 12),
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: 46, height: 46,
                  decoration: BoxDecoration(
                    color: C.bgSurface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: C.border),
                  ),
                  child: Center(
                    child: Text(_emojiFor(task.workoutType),
                        style: const TextStyle(fontSize: 22))),
                ),
                if (task.isDone)
                  Positioned(
                    top: -4, right: -4,
                    child: Container(
                      width: 18, height: 18,
                      decoration: BoxDecoration(
                        color: C.success, shape: BoxShape.circle,
                        border: Border.all(color: C.bg, width: 2)),
                      child: const Icon(Icons.check_rounded,
                          color: Colors.white, size: 10),
                    ),
                  ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}