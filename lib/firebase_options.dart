// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAdB7xdEi2Ce1m8XP4kemWyfj-F5tynURw',
    appId: '1:989157903143:web:a06968ce40c0fdc2203702',
    messagingSenderId: '989157903143',
    projectId: 'aplikasijudibola69',
    authDomain: 'aplikasijudibola69.firebaseapp.com',
    storageBucket: 'aplikasijudibola69.firebasestorage.app',
    measurementId: 'G-0EWD94QYC0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhalLGu_4UGuACRvLUhcGFIJoal6PnJIw',
    appId: '1:989157903143:android:e2109ffce053e256203702',
    messagingSenderId: '989157903143',
    projectId: 'aplikasijudibola69',
    storageBucket: 'aplikasijudibola69.firebasestorage.app',
  );
}
