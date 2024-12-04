import 'package:bolanet76/app/modules/home/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatelessWidget {
  final AuthController authController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang dengan gradasi biru tua (navy) dan biru gelap
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF001f3d), // Biru tua
                  Color(0xFF003366), // Biru gelap
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Konten utama
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100), // Jarak atas
                  Text(
                    'Daftar Akun Baru',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40), // Jarak antara judul dan input
                  _buildTextField(
                    controller: firstNameController,
                    labelText: 'Nama Depan',
                    obscureText: false,
                  ),
                  SizedBox(height: 20), // Jarak antara input
                  _buildTextField(
                    controller: lastNameController,
                    labelText: 'Nama Belakang',
                    obscureText: false,
                  ),
                  SizedBox(height: 20), // Jarak antara input
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        birthDateController.text = DateFormat('yyyy-MM-dd')
                            .format(pickedDate); // Format tanggal
                      }
                    },
                    child: AbsorbPointer(
                      child: _buildTextField(
                        controller: birthDateController,
                        labelText: 'Tanggal Lahir',
                        obscureText: false,
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Jarak antara input
                  _buildTextField(
                    controller: emailController,
                    labelText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: 20), // Jarak antara input
                  _buildTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 20), // Jarak antara input
                  ElevatedButton(
                    onPressed: () async {
                      // Panggil metode register dari AuthController
                      await authController.register(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFFF6A13), // Oranye terang
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20), // Jarak bawah
                  TextButton(
                    onPressed: () {
                      Get.back(); // Kembali ke halaman login
                    },
                    child: Text(
                      'Sudah punya akun? Masuk',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun text field dengan desain yang konsisten
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
