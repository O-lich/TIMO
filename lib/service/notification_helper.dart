import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationHelper {
  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  void initialize() {
    const androidInitialize = AndroidInitializationSettings('ic_launcher');
    const iOSInitialize = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    const initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    localNotifications.initialize(initializationSettings);
  }

  Future showNotification({
    required int notificationID,
    required String title,
    required String subtitle,
    required int finalTime,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      "ID",
      "Название уведомления",
      importance: Importance.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    tz.initializeTimeZones();

    await localNotifications.zonedSchedule(
        notificationID,
        title,
        subtitle,
        tz.TZDateTime.now(tz.local).add(Duration(milliseconds: finalTime)),
        generalNotificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  Future cancelNotification({
    required int notificationID,
  }) async {
    await localNotifications.cancel(notificationID);
  }
}
