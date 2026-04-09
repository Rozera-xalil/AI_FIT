import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../controllers/lang_controller.dart';
import 'add_task_sheet.dart';

class AddTaskFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Get.bottomSheet(
        const AddTaskSheet(),
        isScrollControlled: true,
        backgroundColor: C.bgCard,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24))),
      ),
      backgroundColor: C.purple,
      icon: const Icon(Icons.add_rounded, color: Colors.white),
      label: GetBuilder<LangController>(
        builder: (_) => Text('add_task'.tr,
            style: const TextStyle(
                fontFamily: 'Rajdhani',
                fontWeight: FontWeight.w700, color: Colors.white)),
      ),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
    );
  }
}