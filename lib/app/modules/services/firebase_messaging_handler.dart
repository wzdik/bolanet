import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Pesan diterima di background: ${message.notification?.title}');
}

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    // Inisialisasi Flutter Local Notifications untuk notifikasi lokal
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Meminta izin dari pengguna untuk mengirim notifikasi
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Izin yang diberikan pengguna: ${settings.authorizationStatus}');

    // Mendapatkan token FCM
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    // Menangani pesan ketika aplikasi dalam keadaan terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("Pesan saat aplikasi terminated: ${message.notification?.title}");
      }
    });

    // Menangani pesan saat aplikasi dalam keadaan background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Menangani pesan saat aplikasi berada di latar depan
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Pesan diterima di foreground: ${message.notification?.title}');

      // Menampilkan notifikasi lokal saat di foreground
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'your_channel_id', // Ganti dengan channel id Anda
              'your_channel_name', // Ganti dengan channel name Anda
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });
  }
}
