import 'dart:async';
import 'package:get/get.dart';
import 'package:dashky_finance/screen/login_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key}); //

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.to(LoginView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png', // Ganti dengan path logo Anda
              width:
                  300, // Ukuran logo lebih besar (sesuaikan sesuai kebutuhan)
              height:
                  300, // Ukuran logo lebih besar (sesuaikan sesuai kebutuhan)
            ),
            const SizedBox(height: 20), // Space between logo and text
            // Text for version and credit
            Column(
              children: [
                Text(
                  'Version 1.0.0', // Change the version number as needed
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(
                    height: 5), // Space between version and credit text
                Text(
                  'Powered by Dashky', // Credit text
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
