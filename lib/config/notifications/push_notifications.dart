import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:match_home_client/config/notifications/access_firebase_token.dart';

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  final data = <String, dynamic>{
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'id': '1',
    'status': 'done'
  };

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  }

  static Future initialize() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  void onMessageListener() {
    //segundo plano
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        final routeFromMessage = value.data['route'];
        print('routeFromMessage: $routeFromMessage');
        print('value.data: ${value.data}');
      }
    });
    //primer plano
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    //cuando toco la notificacion
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    });
  }

  Future<void> sendNotification({
    required String to,
    required Map<String, dynamic> data,
    required String title,
    required String body,
  }) async {
    final getToken = AccessTokenFirebase();
    final accessToken = await getToken.getAccessToken();
    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/match-home-741c2/messages:send');
    final message = {
      "message": {
        "token": to,
        "notification": {
          "title": title,
          "body": body,
        },
        "data": data,
        "android": {
          "priority": "HIGH",
        },
        "apns": {
          "headers": {
            "apns-priority": "10",
          },
          "payload": {
            "aps": {
              "content-available": 1,
            },
          },
        },
      },
    };

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(message),
    );

    print('response: ${response.body}');

    if (response.statusCode == 200) {
      print('Notification sent');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }

  Future<void> sendNotifications(
      {required String name, required String token, String? message}) async {
    String messageNew = 'Se ha hecho match con el usuario $name';
    print('token: $token');
    sendNotification(
        to: token,
        data: data,
        title: 'Nuevo match',
        body: message ?? messageNew);
  }
}
