import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang Aplikasi',
          style: TextStyle(
            color: Colors.white, // White text for title
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        backgroundColor: Colors.blue[900], // Dark blue for header
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back to the Profile page
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
              'Tentang Aplikasi Dashky Finance',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue color for heading
              ),
            ),
            SizedBox(height: 16),

            // Description Section
            Text(
              'Dashky Finance adalah aplikasi yang dirancang untuk membantu Anda mengelola simpanan, pinjaman, dan transaksi keuangan di koperasi simpan pinjam dengan mudah dan aman. Aplikasi ini menyediakan berbagai fitur untuk memantau pengeluaran, mencatat simpanan, mengelola pinjaman, serta membantu Anda mencapai tujuan keuangan pribadi.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24),

            // Features Section
            Text(
              'Fitur utama aplikasi ini:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1. Pencatatan simpanan dan pinjaman yang mudah dan cepat',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '2. Pelaporan dan analisis keuangan untuk membantu perencanaan finansial',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '3. Pengingat dan notifikasi untuk simpanan dan cicilan pinjaman',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '4. Pengaturan anggaran dan tujuan keuangan pribadi',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),

            // Developer Section
            Text(
              'Pengembang: Tim Dashky Finance',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Versi: 1.0.0',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),

            // Credit Section
            Text(
              'Terima kasih telah menggunakan aplikasi Dashky Finance kami!',
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
