import 'package:bolanet76/app/modules/home/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Menyimpan status untuk melihat atau menyembunyikan password
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang dengan warna biru tua (navy) untuk kesan profesional
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF001f3d), // Biru tua
                  Color(0xFF003366), // Biru yang lebih gelap
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Konten halaman
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo atau gambar latar belakang (opsional)
                  Image.network(
                    'https://static.vecteezy.com/system/resources/thumbnails/028/259/935/small_2x/breaking-live-stream-sport-news-in-abstract-style-on-dark-abstract-background-business-design-motion-graphics-video.jpg', // Gantilah dengan gambar logo Anda
                    width: 230,
                    height: 180,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Selamat Datang!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  // Field untuk email dengan desain lebih menarik
                  _buildTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  // Field untuk password dengan desain lebih menarik
                  _buildTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: _obscureText,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText =
                              !_obscureText; // Toggle untuk melihat/sembunyikan password
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  // Tombol login dengan warna oranye untuk aksen
                  Obx(() {
                    return ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : () async {
                              await authController.login(emailController.text,
                                  passwordController.text);
                            },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFFF6A13), // Oranye terang
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: authController.isLoading.value
                          ? CircularProgressIndicator()
                          : Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  }),
                  SizedBox(height: 20),
                  // Tombol untuk menuju halaman registrasi
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/register');
                    },
                    child: Text(
                      'Belum punya akun? Daftar di sini',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
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
    required String hintText,
    required bool obscureText,
    Widget? suffixIcon,
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
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
          suffixIcon:
              suffixIcon, // Menambahkan ikon untuk melihat/sembunyikan password
        ),
      ),
    );
  }
}
