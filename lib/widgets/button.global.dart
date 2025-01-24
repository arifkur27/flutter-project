import 'package:dashky_finance/utils/global.colors.dart';
import 'package:flutter/material.dart';

class Buttonglobal extends StatelessWidget {
  final String buttonText; // Parameter untuk teks tombol
  final VoidCallback? onTap; // Parameter opsional untuk callback saat tombol ditekan

  const Buttonglobal({
    super.key,
    required this.buttonText,
    this.onTap, // Terima fungsi callback opsional saat pemanggilan
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {
        print(buttonText); // Aksi default jika onTap tidak disediakan
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          buttonText, // Tampilkan teks dinamis
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
