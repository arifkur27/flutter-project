import 'package:dashky_finance/utils/global.colors.dart';
import 'package:dashky_finance/widgets/button.global.dart';
import 'package:dashky_finance/widgets/social.login.dart';
import 'package:dashky_finance/widgets/text.form.global.dart';
import 'package:dashky_finance/screen/login_view.dart';
import 'package:dashky_finance/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> _register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showSnackbar("Error", "Semua kolom wajib diisi");
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) {
      _showSnackbar("Error", "Email tidak valid");
      return;
    }

    if (password != confirmPassword) {
      _showSnackbar("Error", "Kata sandi tidak cocok");
      return;
    }

    var user = await UserService.register(email, password);
    if (user != null) {
      _showSnackbar("Sukses", "Pendaftaran berhasil");
      Get.to(() => const LoginView());
    } else {
      _showSnackbar("Error", "Pendaftaran gagal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Create your Account',
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                _buildPasswordField(
                  controller: passwordController,
                  hintText: 'Kata Sandi',
                  isPasswordVisible: isPasswordVisible,
                  toggleVisibility: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 10),
                _buildPasswordField(
                  controller: confirmPasswordController,
                  hintText: 'Konfirmasi Kata Sandi',
                  isPasswordVisible: isConfirmPasswordVisible,
                  toggleVisibility: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Buttonglobal(
                  buttonText: 'Daftar',
                  onTap: _register,
                ),
                const SizedBox(height: 25),
                SocialLogin(isLogin: false),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sudah memiliki akun?"),
            InkWell(
              onTap: () {
                Get.to(() => const LoginView());
              },
              child: Text(
                'Masuk',
                style: TextStyle(
                  color: GlobalColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isPasswordVisible,
    required VoidCallback toggleVisibility,
  }) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: GlobalColors.mainColor,
            ),
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }
}
