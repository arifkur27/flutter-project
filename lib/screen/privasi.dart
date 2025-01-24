import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kebijakan Privasi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        // Add back button with white color
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Title Section
            Text(
              'Kebijakan Privasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // Blue color for heading
              ),
            ),
            SizedBox(height: 16),

            // Description Section
            Text(
              'Kami di Dashky Finance sangat menghargai privasi Anda. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi data pribadi Anda ketika Anda menggunakan aplikasi kami.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24),

            // Data Collection Section
            Text(
              '1. Pengumpulan Data Pribadi:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Kami mengumpulkan data pribadi Anda saat Anda mendaftar, termasuk nama, alamat email, nomor telepon, dan data lain yang diperlukan untuk memberikan layanan kami.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),

            // Data Usage Section
            Text(
              '2. Penggunaan Data Pribadi:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Data yang kami kumpulkan digunakan untuk memberikan dan meningkatkan layanan kami, termasuk untuk menghubungi Anda terkait transaksi dan aktivitas akun.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),

            // Data Protection Section
            Text(
              '3. Perlindungan Data Pribadi:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Kami mengambil langkah-langkah yang wajar untuk melindungi data pribadi Anda dari akses yang tidak sah, penggunaan, atau pengungkapan.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),

            // Data Sharing Section
            Text(
              '4. Pembagian Data Pribadi:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Kami tidak membagikan data pribadi Anda dengan pihak ketiga kecuali jika diwajibkan oleh hukum atau untuk tujuan yang diperlukan dalam penyediaan layanan.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),

            // User Rights Section
            Text(
              '5. Hak Pengguna:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Anda berhak untuk mengakses, memperbarui, atau menghapus data pribadi Anda yang kami simpan. Jika Anda ingin menggunakan hak ini, silakan hubungi kami melalui email.',
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
              'Jika Anda memiliki pertanyaan lebih lanjut mengenai kebijakan privasi ini, Anda dapat menghubungi kami melalui email di support@dashkyfinance.com.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),

            // Credit Section
            Text(
              'Terima kasih telah mempercayakan privasi Anda kepada Dashky Finance!',
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
