import 'package:bolanet76/app/modules/home/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Menggunakan Get.put untuk menginisialisasi AuthController
    Get.put(AuthController());
  }
}
