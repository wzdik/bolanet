import 'package:bolanet76/app/modules/home/controllers/auth_controller.dart';
import 'package:bolanet76/app/modules/services/firebase_messaging_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController()); // Inisialisasi Firebase

  // Inisialisasi notifikasi push
  FirebaseMessagingHandler firebaseMessagingHandler =
      FirebaseMessagingHandler();
  await firebaseMessagingHandler.initPushNotification();

  runApp(
    GetMaterialApp(
      title: "Football News Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug
    ),
  );
}
