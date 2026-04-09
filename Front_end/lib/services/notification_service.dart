import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    await _plugin.initialize(
        const InitializationSettings(android: android, iOS: ios));
    _initialized = true;
  }

  static Future<void> scheduleWorkoutReminder({
    required int id,
    required String taskName,
    required DateTime scheduledTime,
  }) async {
    await init();
    final title = 'notif_title'.tr;
    final body = 'notif_body'.tr + taskName;
    try {
      await _plugin.zonedSchedule(
        id, title, body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'krd_fit_workout', 'Workout Reminders',
            channelDescription: 'Reminders for your scheduled workouts',
            importance: Importance.max, priority: Priority.high,
            playSound: true, enableVibration: true,
            icon: '@mipmap/ic_launcher',
            color: Color(0xFF8B5CF6),
          ),
          iOS: DarwinNotificationDetails(
              presentSound: true, presentAlert: true, presentBadge: true),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      debugPrint('Notification error: $e');
    }
  }

  static Future<void> cancelNotification(int id) async =>
      _plugin.cancel(id);
  static Future<void> cancelAll() async => _plugin.cancelAll();
}