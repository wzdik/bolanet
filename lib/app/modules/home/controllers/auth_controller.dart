import 'package:bolanet76/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isLoading = false.obs; // Reactive variable for loading state
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true; // Set loading to true when starting login
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoggedIn.value = true; // Update login status
      Get.offNamed(Routes.HOME); // Navigate to home page after login
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM); // Show error message
    } finally {
      isLoading.value =
          false; // Set loading to false once the login is complete
    }
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true; // Set loading to true when starting registration
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoggedIn.value = true; // Update login status
      Get.offNamed(Routes.LOGIN); // Navigate to login page after registration
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM); // Show error message
    } finally {
      isLoading.value =
          false; // Set loading to false once the registration is complete
    }
  }

  void logout() {
    isLoggedIn.value = false;
    Get.offAllNamed(Routes.LOGIN); // Navigate to login page after logout
  }
}
