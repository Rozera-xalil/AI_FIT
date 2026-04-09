import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static String formatDate(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }
  
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
  
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('EEE, MMM d  •  HH:mm').format(dateTime);
  }
  
  static String getWorkoutEmoji(String workoutType) {
    if (workoutType.contains('HIIT')) return '🔥';
    if (workoutType.contains('Hêz') ||
        workoutType.contains('Strength') ||
        workoutType.contains('Force')) return '💪';
    if (workoutType.contains('Kardîyo') || workoutType.contains('Cardio')) return '🏃';
    return '🧘';
  }
}