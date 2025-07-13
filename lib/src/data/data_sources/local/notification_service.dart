import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../core/constants/app_strings.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showQuizReminder() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'quiz_reminder_channel',
      'Quiz Reminders',
      channelDescription: 'Notifications for quiz reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      AppStrings.quizReminderTitle,
      AppStrings.quizReminderBody,
      notificationDetails,
    );
  }

  Future<void> showLearningPathReminder() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'learning_path_reminder_channel',
      'Learning Path Reminders',
      channelDescription: 'Notifications for learning path progress',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      1,
      AppStrings.learningPathReminderTitle,
      AppStrings.learningPathReminderBody,
      notificationDetails,
    );
  }
}
