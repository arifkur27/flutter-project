import 'package:flutter/material.dart';



class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Syarat dan Ketentuan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: Colors.blue[900], // Dark blue for header
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Logo Image Section
            Center(
              child: Image.asset(
                'assets/logos.png', // Path to your logo image
                height: 100, // Set the height of the logo
                width: 100,  // Set the width of the logo
              ),
            ),
            SizedBox(height: 16),

            // Title Section
            Text(
              'Dashky Finance',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue color for heading
              ),
            ),
            SizedBox(height: 16),

            // Description Section
            Text(
              'Selamat datang di Dashky Finance. Sebelum Anda menggunakan layanan kami, harap baca dengan teliti syarat dan ketentuan berikut. Dengan menggunakan aplikasi ini, Anda setuju untuk terikat oleh syarat dan ketentuan yang berlaku.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24),

            // Key Terms and Conditions Section
            Text(
              'Ketentuan Umum:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Pengguna wajib berusia 18 tahun ke atas untuk menggunakan aplikasi.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '2. Pengguna diwajibkan untuk memberikan informasi yang akurat dan lengkap saat mendaftar.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '3. Pengguna bertanggung jawab atas semua transaksi yang dilakukan melalui aplikasi.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '4. Kami berhak untuk menangguhkan atau menghentikan akun jika ada pelanggaran syarat dan ketentuan.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),

            // Rights and Obligations Section
            Text(
              'Hak dan Kewajiban Pengguna:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Pengguna berhak untuk menggunakan layanan simpan pinjam yang tersedia di aplikasi.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '2. Pengguna wajib menjaga kerahasiaan data pribadi dan informasi akun mereka.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '3. Pengguna bertanggung jawab atas pengelolaan simpanan dan pinjaman yang dilakukan melalui aplikasi.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),

            // Limitation of Liability Section
            Text(
              'Batasan Tanggung Jawab:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Kami tidak bertanggung jawab atas kerugian yang timbul akibat penggunaan aplikasi di luar ketentuan yang ada.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '2. Dashky Finance Koperasi Simpan Pinjam tidak bertanggung jawab atas kerusakan perangkat yang digunakan oleh pengguna.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),

            // Contact Section
            Text(
              'Hubungi Kami:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Jika Anda memiliki pertanyaan lebih lanjut mengenai syarat dan ketentuan ini, Anda dapat menghubungi kami melalui email di support@dashkyfinance.com.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),

            // Credit Section
            Text(
              'Terima kasih telah menggunakan layanan kami!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
