import 'package:flutter/material.dart';

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coming Soon',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20, // Slightly smaller title
          ),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        automaticallyImplyLeading: false, // This ensures no back button is displayed
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0), // Adjust padding for better layout
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon to indicate Coming Soon
              Icon(
                Icons.hourglass_empty, // Hourglass icon
                size: 120,
                color: Colors.blue[900],
              ),
              SizedBox(height: 24), // Increase space between icon and text

              // Main Title Text
              Text(
                'Terima kasih telah menggunakan aplikasi kami.\nFitur ini akan hadir dalam pembaruan berikutnya!',
                textAlign: TextAlign.center, // Center-align text for better readability
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500, // Slightly lighter weight for better readability
                  color: Colors.blue[900],
                  height: 1.6, // Improve line spacing
                ),
              ),
              SizedBox(height: 30), // Additional space below text

              // Optional back button without primary color
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
                child: Text('Kembali', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
