import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/lang_controller.dart';
import '../../controllers/tasks_controller.dart';
import '../../models/workout_task.dart';
import '../common/primary_button.dart';
import '../common/field_widget.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _nameCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(hours: 1));
  String _workoutType = 'HIIT';
  final _types = ['HIIT', 'Strength', 'Cardio', 'Yoga'];

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(primary: C.purple)),
        child: child!,
      ),
    );
    if (date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(primary: C.purple)),
        child: child!,
      ),
    );
    if (time == null) return;
    setState(() {
      _selectedDate = DateTime(
          date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 36, height: 4,
          decoration: BoxDecoration(
              color: C.border, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(height: 20),
        GetBuilder<LangController>(
          builder: (_) => Text('add_task'.tr,
              style: const TextStyle(
                  fontFamily: 'Rajdhani',
                  fontSize: 20, fontWeight: FontWeight.w700,
                  color: C.textPrim)),
        ),
        const SizedBox(height: 20),
        GetBuilder<LangController>(
          builder: (_) => FieldWidget(
              ctrl: _nameCtrl,
              hint: 'task_name'.tr,
              icon: Icons.edit_rounded),
        ),
        const SizedBox(height: 14),
        Row(
          children: _types.map((t) => Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _workoutType = t),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: t != _types.last ? 6 : 0),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  gradient: _workoutType == t ? C.gradPrimary : null,
                  color: _workoutType == t ? null : C.bgSurface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _workoutType == t
                        ? Colors.transparent
                        : C.border),
                ),
                child: Column(children: [
                  Text(_emojiFor(t),
                      style: const TextStyle(fontSize: 16)),
                  Text(t,
                      style: TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 9,
                          color: _workoutType == t
                              ? Colors.white
                              : C.textSec,
                          fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: _pickDateTime,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: C.bgSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: C.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.access_time_rounded,
                      color: C.purple, size: 16),
                  const SizedBox(width: 8),
                  Text(
                      'EEE, MMM d  •  HH:mm', // Would use intl in real app
                      style: const TextStyle(
                          fontFamily: 'Rajdhani',
                          fontSize: 14, color: C.textPrim,
                          fontWeight: FontWeight.w600)),
                ]),
                const Icon(Icons.chevron_right_rounded,
                    color: C.textSec, size: 18),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          onTap: () {
            if (_nameCtrl.text.trim().isEmpty) return;
            final ctrl = Get.find<TasksController>();
            ctrl.addTask(WorkoutTask(
              id: ctrl.nextId,
              name: _nameCtrl.text.trim(),
              workoutType: _workoutType,
              scheduledAt: _selectedDate,
            ));
            Get.back();
          },
          child: GetBuilder<LangController>(
            builder: (_) => Text('save_task'.tr,
                style: const TextStyle(
                    fontFamily: 'Rajdhani',
                    fontSize: 17, fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
        ),
      ]),
    );
  }

  String _emojiFor(String t) {
    switch (t) {
      case 'HIIT': return '🔥';
      case 'Strength': return '💪';
      case 'Cardio': return '🏃';
      default: return '🧘';
    }
  }
}