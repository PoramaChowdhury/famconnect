import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await requestPermissions();
// <<<<<<< ibshar

//     // Initialize timezone database and set default location
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Asia/Dhaka')); // Replace with your region if needed

//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _notificationsPlugin.initialize(initializationSettings);
//   }

//   NotificationDetails _notificationDetails() {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         'your_channel_id', // Replace with unique ID
//         'your_channel_name', // Replace with user-friendly name
//         channelDescription: 'your_channel_description',
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: true,
//         playSound: true,
//         enableVibration: true,
//         ticker: 'ticker',
//         visibility: NotificationVisibility.public,
// =======
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Dhaka'));
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'event_reminder_channel', // Unique channel ID
        'Event Reminders', // User-visible channel name
        channelDescription: 'Event reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        visibility: NotificationVisibility.public,
        ticker: 'Reminder ticker',
//>>>>>>> master
      ),
    );
  }

  Future<void> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  }

  Future<void> foregroundNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notificationsPlugin.show(id, title, body, _notificationDetails(), payload: payload);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime selectedTime,
  }) async {
    if (selectedTime.isBefore(DateTime.now())) {
// <<<<<<< ibshar
//       selectedTime = selectedTime.add(const Duration(days: 1));
//     }

//     final tz.TZDateTime scheduledTime = tz.TZDateTime.from(selectedTime, tz.local);

// =======
      selectedTime = selectedTime.add(const Duration(minutes: 1));
    }
    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(selectedTime, tz.local);
//>>>>>>> master
    try {
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
// <<<<<<< ibshar
//         matchDateTimeComponents: DateTimeComponents.time,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//       );
//       print('Notification scheduled successfully');
//     } catch (e) {
//       print('Error scheduling notification: $e');
//     }
//   }

//   Future<void> periodicNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     try {
//       await _notificationsPlugin.periodicallyShow(
//         id,
//         title,
//         body,
//         RepeatInterval.hourly, // Change to daily or weekly as needed
//         _notificationDetails(),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       );
//       print('Periodic notification set successfully');
//     } catch (e) {
//       print('Error setting periodic notification: $e');
//     }
//   }
// =======
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('Notification scheduled for: \$scheduledTime');
    } catch (e) {
      print('Error scheduling notification: \$e');
    }
  }


  /*Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime selectedTime,
  }) async {
    final DateTime safeTime = selectedTime.isBefore(DateTime.now())
        ? DateTime.now().add(const Duration(minutes: 1))
        : selectedTime;

    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(safeTime, tz.local);
    try {
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('Notification scheduled for: $scheduledTime');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }*/

//>>>>>>> master

  Future<void> unsubscribeToAllNotification() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<void> unsubscribeToSpecificNotification({required int id}) async {
    await _notificationsPlugin.cancel(id);
  }
}
