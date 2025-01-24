import 'package:dashky_finance/utils/global.colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLogin extends StatelessWidget {
  final bool isLogin; // Tambahkan parameter isLogin

  const SocialLogin({super.key, required this.isLogin}); // Inisialisasi parameter

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            isLogin ? '- or sign in with -' : '- or sign up with -', // Tampilkan teks sesuai dengan isLogin
            style: TextStyle(
              color: GlobalColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            children: [
              // Google
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
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
                  child: SvgPicture.asset('assets/google.svg', height: 25),
                ),
              ),
              const SizedBox(width: 10),
              // Facebook
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
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
                  child: SvgPicture.asset('assets/facebook.svg', height: 25),
                ),
              ),
              const SizedBox(width: 10),
              // Instagram
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 55,
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
                  child: SvgPicture.asset('assets/instagram.svg', height: 25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
