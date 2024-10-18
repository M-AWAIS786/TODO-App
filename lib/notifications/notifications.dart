import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //Initialize the Flutter Local Notifications Plugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<List<PendingNotificationRequest>>
      getPendingNotificationRequest() async {
    return await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  static Future<void> cancelPendingNotificationRequest(int id) async {
    return await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {}

  //Initialize the nofifaction plugin
  static Future<void> init() async {
    //Define the Android initialization settings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    //Define the Darwin initialization settings
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    //Combine Android and IOS Initializations settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    //Initialize the plugin with specified settings
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotification,
        onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification);

    // Request notification permission for android

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // show and instant notification
  static Future<void> showInstantNotification(
      int id, String title, String body, String category) async {
    //Define the notifacations details
    const NotificationDetails platformChannelSpecifies = NotificationDetails(
        android: AndroidNotificationDetails('channel_Id', 'channel_Name',
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifies, payload: category);
  }

// show and Schedule notification

  static Future<void> scheduleNotification(int id, String title, String body,
      DateTime scheduleDate, String category) async {
    //Define the notifacations details
    const NotificationDetails platformChannelSpecifies = NotificationDetails(
        android: AndroidNotificationDetails('channel_Id', 'channel_Name',
            importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails());

    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(scheduleDate, tz.local), platformChannelSpecifies,
        payload: category,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }
}
