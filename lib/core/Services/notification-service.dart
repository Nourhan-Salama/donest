import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_app/core/Utils/app-logger.dart';

class NotificationService {
  //creates **ONE and ONLY ONE** notification manager for the entire app
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize notification service
  Future<void> initialize() async {
    AppLogger.info('🔔 Initializing notifications...');
    
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _notificationsPlugin.initialize(initSettings);
    
    AppLogger.success('✅ Notifications initialized');
  }

  /// Request permissions (Android 13+)
  Future<bool> requestPermissions() async {
    if (await Permission.notification.isDenied) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return true;
  }

  /// ✅ 1. Incomplete Task Notification
  Future<void> showIncompleteTaskNotification({
    required int taskCount,
  }) async {
    AppLogger.info('📢 Showing incomplete task notification');

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'incomplete_tasks',
      'Incomplete Tasks',
      channelDescription: 'Reminders for incomplete tasks',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('incomplete_task'), // ✅ Custom sound
      playSound: true,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      sound: 'default', // ✅ Custom sound
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notificationsPlugin.show(
      1, // Fixed ID for incomplete tasks
      '⏰ Incomplete Tasks',
      'You have $taskCount incomplete task${taskCount > 1 ? 's' : ''} today!',
      platformDetails,
    );

    AppLogger.success('✅ Incomplete task notification sent');
  }

  /// ✅ 2. Daily Encouragement Notification
  Future<void> showEncouragementNotification() async {
    AppLogger.info('💪 Showing encouragement notification');

    final encouragements = [
      'You can do it! Start your tasks today! 💪',
      'Great things never come from comfort zones! 🚀',
      'Small progress is still progress! 🌟',
      'Today is a fresh start! Let\'s do this! ☀️',
      'You\'re doing amazing! Keep it up! 🎯',
      'Every task completed is a win! 🏆',
      'Believe in yourself! You got this! ✨',
      'One step at a time! You\'re awesome! 🌈',
    ];

    final randomMessage = encouragements[
      DateTime.now().millisecond % encouragements.length
    ];

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'encouragement',
      'Daily Encouragement',
      channelDescription: 'Daily motivational messages',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('encouragement'), // ✅ Custom sound
      playSound: true,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      sound: 'default', // ✅ Custom sound
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notificationsPlugin.show(
      2, // Fixed ID for encouragement
      '💪 Keep Going!',
      randomMessage,
      platformDetails,
    );

    AppLogger.success('✅ Encouragement notification sent');
  }

  /// ✅ 3. All Tasks Completed Notification (Celebration)
  Future<void> showCelebrationNotification() async {
    AppLogger.info('🎉 Showing celebration notification');

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'celebration',
      'Celebration',
      channelDescription: 'Celebration when all tasks completed',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('celebration'), // ✅ Custom sound
      playSound: true,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      sound: 'default', // ✅ Custom sound
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notificationsPlugin.show(
      3, // Fixed ID for celebration
      '🎉 Congratulations!',
      'You completed all your tasks today! Amazing work! 🏆',
      platformDetails,
    );

    AppLogger.success('✅ Celebration notification sent');
  }

  /// Schedule daily encouragement at random time
  Future<void> scheduleDailyEncouragement() async {
    AppLogger.info('📅 Scheduling daily encouragement');

    // Random time between 10 AM and 8 PM
    final now = DateTime.now();
    final randomHour = 10 + (now.millisecond % 11); // 10-20 (8 PM)
    final randomMinute = now.second % 60;

    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      randomHour,
      randomMinute,
    );

    // If time already passed today, schedule for tomorrow
    final finalScheduledTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(Duration(days: 1))
        : scheduledTime;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'encouragement',
      'Daily Encouragement',
      channelDescription: 'Daily motivational messages',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('encouragement'),
      playSound: true,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      sound: 'default',
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    final encouragements = [
      'You can do it! Start your tasks today! 💪',
      'Great things never come from comfort zones! 🚀',
      'Small progress is still progress! 🌟',
    ];

    final randomMessage = encouragements[
      DateTime.now().millisecond % encouragements.length
    ];

    await _notificationsPlugin.zonedSchedule(
      2,
      '💪 Keep Going!',
      randomMessage,
      tz.TZDateTime.from(finalScheduledTime, tz.local),
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    
    );

    AppLogger.success('✅ Daily encouragement scheduled for $finalScheduledTime');
  }

  /// Schedule end-of-day incomplete task check
  Future<void> scheduleEndOfDayCheck() async {
    AppLogger.info('📅 Scheduling end of day check');

    // Schedule for 8 PM today
    final now = DateTime.now();
    final scheduledTime = DateTime(now.year, now.month, now.day, 20, 0);

    // If 8 PM passed, schedule for tomorrow
    final finalScheduledTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(Duration(days: 1))
        : scheduledTime;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'incomplete_tasks',
      'Incomplete Tasks',
      channelDescription: 'Reminders for incomplete tasks',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('incomplete_task'),
      playSound: true,
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      sound: 'default',
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notificationsPlugin.zonedSchedule(
      1,
      '⏰ End of Day Check',
      'Time to review your tasks!',
      tz.TZDateTime.from(finalScheduledTime, tz.local),
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      
    );

    AppLogger.success('✅ End of day check scheduled for $finalScheduledTime');
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
    AppLogger.info('🗑️ All notifications canceled');
  }
}