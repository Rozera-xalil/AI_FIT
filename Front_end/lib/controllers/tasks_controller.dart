import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_recommenation_ai_sys/constants/colors.dart';
import '../models/workout_task.dart';
import '../services/notification_service.dart';
import 'package:flutter/material.dart';
class TasksController extends GetxController {
  final tasks = <WorkoutTask>[].obs;
  static const _storageKey = 'krd_fit_tasks';

  @override
  void onInit() {
    super.onInit();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_storageKey) ?? [];
    tasks.value = raw.map((s) => WorkoutTask.fromJson(jsonDecode(s))).toList();
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        _storageKey, tasks.map((t) => jsonEncode(t.toJson())).toList());
  }

  Future<void> addTask(WorkoutTask task) async {
    tasks.add(task);
    await _saveTasks();
    final notifyTime = task.scheduledAt.subtract(const Duration(minutes: 10));
    if (notifyTime.isAfter(DateTime.now())) {
      await NotificationService.scheduleWorkoutReminder(
          id: task.id, taskName: task.name, scheduledTime: notifyTime);
    }
    Get.snackbar(
      'reminder_set'.tr, task.name,
      backgroundColor: C.purple.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
    );
  }

  Future<void> toggleDone(int id) async {
    final idx = tasks.indexWhere((t) => t.id == id);
    if (idx != -1) {
      tasks[idx].isDone = !tasks[idx].isDone;
      tasks.refresh();
      await _saveTasks();
    }
  }

  Future<void> deleteTask(int id) async {
    await NotificationService.cancelNotification(id);
    tasks.removeWhere((t) => t.id == id);
    await _saveTasks();
  }

  int get nextId => tasks.isEmpty
      ? 1
      : tasks.map((t) => t.id).reduce((a, b) => a > b ? a : b) + 1;

  List<WorkoutTask> get upcoming => tasks
      .where((t) => !t.isDone && t.scheduledAt.isAfter(DateTime.now()))
      .toList()
    ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

  List<WorkoutTask> get past => tasks
      .where((t) => t.isDone || t.scheduledAt.isBefore(DateTime.now()))
      .toList()
    ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
}