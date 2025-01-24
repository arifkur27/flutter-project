import 'package:flutter/material.dart';
import '../service/user_service.dart';
import 'bayar_page.dart'; // Import the BayarPage screen
import 'dashboard.dart'; // Import the Dashboard screen
import 'profile.dart'; // Import the Profile screen
import 'pinjaman.dart'; // Import the Pinjaman page
import 'topup.dart'; // Import the TopUpPage screen
import 'coming.dart'; // Import the ComingPage screen

class Simpanan extends StatefulWidget {
  @override
  _SimpananState createState() => _SimpananState();
}

class _SimpananState extends State<Simpanan> {
  int _selectedBottomTabIndex = 1; // Set default to Simpanan
  String _selectedSortOption = 'Hari ini'; // Default sort option
  List<Map<String, dynamic>> _transactionHistory = []; // Transaction history
  UserService userService = UserService();

  void _onBottomTabSelected(int index) {
    setState(() {
      _selectedBottomTabIndex = index;
    });

    // Handle navigation based on selected tab
    if (index == 1) {
      // Simpanan is already selected (do nothing)
    } else if (index == 0) {
      // Navigate to Home (Dashboard.dart)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DashboardView()), // Navigate to Dashboard
      );
    } else if (index == 2) {
      // Navigate to Pinjaman page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Pinjaman()), // Navigate to PinjamanPage
      );
    } else if (index == 3) {
      // Navigate to Profile page (Profile.dart)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen()), // Navigate to Profile
      );
    }
  }

  // Function to handle Top Up action
  void _handleTopUp(double amount) {
    setState(() {
      // _balance += amount; // Increase the balance by the top-up amount
      userService.addBalance(amount);
      _transactionHistory.add({
        'type': 'Top Up',
        'amount': amount,
        'date': DateTime.now().toString(),
      });
    });
  }

  // Function to handle Bayar (payment) action
  void _handleBayar(double amount) {
    setState(() {
      if (userService.saldo >= amount) {
        userService.penguranganBalance(
            amount); // Decrease the balance by the payment amount
        _transactionHistory.add({
          'type': 'Bayar',
          'amount': amount,
          'date': DateTime.now().toString(),
        });
      } else {
        // Show a message if the balance is insufficient
        _showInsufficientBalanceDialog();
      }
    });
  }

  // Function to show insufficient balance dialog
  void _showInsufficientBalanceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Saldo Tidak Cukup'),
          content: Text('Saldo Anda tidak cukup untuk melakukan pembayaran.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(userService.saldo);
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
              _buildBalanceCard(),
              SizedBox(height: 20),
              _buildIconRow(),
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
              style:
                  TextStyle(color: Colors.black54), // Darker text for subtitle
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
                Icon(Icons.star,
                    color: Colors.black, size: 16), // Black star icon
                SizedBox(width: 5),
                Text('Priority',
                    style: TextStyle(
                        color: Colors.black54)), // Darker text for status
              ],
            ),
          ],
        ),
        CircleAvatar(
          backgroundImage:
              AssetImage('assets/profile.jpeg'), // Load image from assets
          radius: 30,
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blue[900], // Black background for the card
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
                'Dashky Financ',
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
            'Rp ${userService.saldo.toStringAsFixed(2)}', // Display updated balance
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '**** **** **** 1234', // Card number with hidden digits
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
        ],
      ),
    );
  }

  Widget _buildIconRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconButton(Icons.payment, 'Bayar'),
        _buildIconButton(Icons.add_circle, 'Top Up'),
        _buildIconButton(Icons.qr_code, 'Scan'),
        _buildIconButton(Icons.receipt_long_rounded, 'Laporan'),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (label == 'Bayar') {
              // Navigate to BayarPage when 'Bayar' icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BayarPage()),
              ).then((amount) {
                if (amount != null) {
                  _handleBayar(amount); // Pass the amount to handle the payment
                }
              });
            } else if (label == 'Top Up') {
              // Navigate to TopUpPage when 'Top Up' icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TopUpPage()),
              ).then((amount) {
                if (amount != null) {
                  _handleTopUp(amount); // Pass the amount to handle the top-up
                }
              });
            } else if (label == 'Scan' || label == 'Laporan') {
              // Navigate to ComingPage when 'Scan' or 'Laporan' icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComingSoonPage()),
              );
            }
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[900], // Blue background for icons
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 30), // White icon
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
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
        // Display transaction history
        ListView.builder(
          shrinkWrap: true,
          itemCount: _transactionHistory.length,
          itemBuilder: (context, index) {
            var transaction = _transactionHistory[index];
            return ListTile(
              title: Text(transaction['type']),
              subtitle: Text(transaction['date']),
              trailing: Text('Rp ${transaction['amount']}'),
            );
          },
        ),
      ],
    );
  }
}
