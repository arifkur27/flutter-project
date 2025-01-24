import 'package:dashky_finance/screen/dashboard2.dart';
import 'package:dashky_finance/screen/laporanpage.dart';
import 'package:dashky_finance/screen/listnasabah.dart';
import 'package:flutter/material.dart'; // Import the dashboard screen
import 'tentang.dart'; // Import the tentang page
import 'sk.dart'; // Import the Syarat & Ketentuan page
import 'privasi.dart'; // Import the Kebijakan Privasi page
import 'coming.dart'; // Import the ComingSoon page

class ProfileScreen2 extends StatefulWidget {
  @override
  _ProfileScreen2State createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2> {
  int _selectedBottomTabIndex = 3; // Profile tab is selected by default

  // Handle bottom navigation tab selection
  void _onBottomTabSelected(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard2Page()),
      );
    } else if (index == 1) {
      // Navigate to List Nasabah
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListNasabahPage()),
      );
    } else if (index == 2) {
      // Navigate to Laporan
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListLaporanPage()),
      );
    } else if (index == 3) {
      // Stay on Profile screen
      setState(() {
        _selectedBottomTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile Picture and Name
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/profile.jpeg'), // Replace with your profile image path
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[900],
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rizky Eka Adinagoro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'bossrizkyid@gmail.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Pengaturan Umum Section
            _buildSectionHeader('Pengaturan Umum'),
            _buildListTile(
              icon: Icons.person,
              title: 'Ganti Info Profil', // Change Profile Info
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to Coming Soon page for "Ganti Info Profil"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComingSoonPage()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.lock,
              title: 'Ganti Password', // Change Password
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to Coming Soon page for "Ganti Password"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComingSoonPage()),
                );
              },
            ),

            // Informasi Section
            _buildSectionHeader('Informasi'),
            _buildListTile(
              icon: Icons.info,
              title: 'Tentang Aplikasi', // About App
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to the TentangPage screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.article,
              title: 'Syarat & Ketentuan', // Terms & Conditions
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to the Syarat & Ketentuan page (SKPage)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
                );
              },
            ),
            _buildListTile(
              icon: Icons.privacy_tip,
              title: 'Kebijakan Privasi', // Privacy Policy
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to the Privacy Policy page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()), // Navigate to Privacy Policy page
                );
              },
            ),
            _buildListTile(
              icon: Icons.share,
              title: 'Bagikan Aplikasi Ini', // Share This App
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to Coming Soon page for "Bagikan Aplikasi Ini"
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComingSoonPage()),
                );
              },
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedBottomTabIndex,
        onTap: _onBottomTabSelected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'List Nasabah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  // ListTile Widget for Settings and Information
  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
