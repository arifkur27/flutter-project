import 'package:flutter/material.dart';
import 'dashboard.dart';  // Import the Dashboard screen
import 'profile.dart';    // Import the Profile screen
import 'simpanan.dart';
import 'bayar_page.dart'; // Import the BayarPage
import 'pinjam.dart'; // Import the PinjamPage
import 'coming.dart'; // Import the ComingPage

class Pinjaman extends StatefulWidget {
  @override
  _PinjamanState createState() => _PinjamanState();
}

class _PinjamanState extends State<Pinjaman> {
  int _selectedBottomTabIndex = 2; // Set default to Pinjaman
  String _selectedSortOption = 'Hari ini'; // Default sort option

  void _onBottomTabSelected(int index) {
    setState(() {
      _selectedBottomTabIndex = index;
    });

    // Handle navigation based on selected tab
    if (index == 2) {
      // Pinjaman is already selected (do nothing)
    } else if (index == 0) {
      // Navigate to Home (Dashboard.dart)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardView()), // Navigate to Dashboard
      );
    } else if (index == 1) {
      // Navigate to Simpanan page (Simpanan.dart)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Simpanan()), // Navigate to Simpanan
      );
    } else if (index == 3) {
      // Navigate to Profile page (Profile.dart)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to Profile
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildLoanCard(),
              SizedBox(height: 20),
              _buildIconRow(), // Updated with 4 icon boxes
              SizedBox(height: 20),
              _buildTransactionSection(),
            ],
          ),
        ),
      ),
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
            icon: Icon(Icons.account_balance_wallet),
            label: 'Simpanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Pinjaman',
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

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang',
              style: TextStyle(color: Colors.black54), // Darker text for subtitle
            ),
            Text(
              'Rizky Eka Adinagoro',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.black, size: 16), // Black star icon
                SizedBox(width: 5),
                Text('Priority', style: TextStyle(color: Colors.black54)), // Darker text for status
              ],
            ),
          ],
        ),
        CircleAvatar(
          backgroundImage: AssetImage('assets/profile.jpeg'), // Load image from assets
          radius: 30,
        ),
      ],
    );
  }

  Widget _buildLoanCard() {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blue[900], // Blue background for the card
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pinjaman Aktif',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.credit_card,
                color: Colors.white54,
                size: 28,
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Rp 50.000.000,00', // Example loan amount
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '**** **** **** 5678', // Card number with hidden digits
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              letterSpacing: 2.0, // Adds spacing between digits
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pemegang Kartu',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  Text(
                    'Rizky Eka Adinagoro',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Berlaku Hingga',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  Text(
                    '12/26', // Example expiration date
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Limit Pinjaman',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              Text(
                'Rp 100.000.000,00', // Example limit
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sisa Pinjaman',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              Text(
                'Rp 50.000.000,00', // Example remaining loan amount
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconBox(Icons.payment, 'Bayar', () {
          // Navigate to BayarPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BayarPage()),
          );
        }),
        _buildIconBox(Icons.add_circle, 'Pinjam', () {
          // Navigate to PinjamPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoanApplicationPage()),
          );
        }),
        _buildIconBox(Icons.qr_code, 'Scan', () {
          // Navigate to ComingPage (Scan)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComingSoonPage()),
          );
        }),
        _buildIconBox(Icons.bar_chart, 'Laporan', () {
          // Navigate to ComingPage (Laporan)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComingSoonPage()),
          );
        }),
      ],
    );
  }

  Widget _buildIconBox(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[900], // Blue background for icons
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 40), // White icon
          ),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTransactionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaksi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  _selectedSortOption,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  onSelected: (String value) {
                    setState(() {
                      _selectedSortOption = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'Hari ini',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Hari ini',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Terlama',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Terlama',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'Paling Banyak',
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Paling Banyak',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        // Add list of transactions here
      ],
    );
  }
}
