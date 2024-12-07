import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_home_client/config/config.dart';
import 'package:match_home_client/config/notifications/push_notifications.dart';
import 'package:match_home_client/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

final pushNotifications = PushNotifications();

@pragma('vm:entry-point')
Future _firebaseBackgroundHandler(RemoteMessage message) async {
  await pushNotifications.setupFlutterNotifications();
  pushNotifications.showFlutterNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51PH72R2KMlDnsnzT8dxn230fC3DaXsXQOVgI7iMrdAo7AYIaXjAiJVeTjYUrNKMqKB6lXsbVTNge47aRf0yGjZSN00QFiDDSN6';
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotifications.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  await pushNotifications.setupFlutterNotifications();
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Utiliza tu clave de reCAPTCHA si es necesaria para web
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.debug,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    pushNotifications.onMessageListener();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Match Home',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
