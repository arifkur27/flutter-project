import 'package:dashky_finance/models/user_models.dart';
import 'package:dashky_finance/screen/dashboard2.dart';
import 'package:dashky_finance/widgets/button.global.dart';
import 'package:dashky_finance/widgets/social.login.dart';
import 'package:dashky_finance/widgets/text.form.global.dart';
import 'package:dashky_finance/screen/register_view.dart';
import 'package:dashky_finance/screen/dashboard.dart'; // Pastikan ini sudah ada
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashky_finance/service/user_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    User? user = await UserService.login(email, password);

    setState(() {
      isLoading = false;
    });

    if (user != null) {
      // Jika admin login
      if (email == UserService.adminEmail) {
        Get.to(() => const Dashboard2Page()); // Halaman admin
      } else {
        Get.to(() => const DashboardView()); // Halaman user biasa
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email atau password salah!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Login to your Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: emailController,
                  text: 'Username',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                Container(
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
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Kata Sandi',
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 18.0),
                      hintStyle: const TextStyle(fontSize: 14),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Buttonglobal(
                  buttonText: isLoading ? 'Loading...' : 'Masuk',
                  onTap: isLoading ? null : _login,
                ),
                const SizedBox(height: 25),
                SocialLogin(isLogin: true),
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
            Text("Belum memiliki akun?"),
            InkWell(
              onTap: () {
                Get.to(() => const RegisterView());
              },
              child: Text(
                'Daftar',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
