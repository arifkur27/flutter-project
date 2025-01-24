import 'package:dashky_finance/service/user_service.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TopUpPage extends StatefulWidget {
  @override
  _TopUpPageState createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _namaPengguna = '';
  String _nomorRekening = '';
  String _bank = '';
  String _virtualAccount = ''; // Virtual Account field
  // double _jumlahTopUp = 0.0;
  TextEditingController topupController = TextEditingController();
  // List of bank options for the user to select
  final List<String> _bankOptions = [
    'BCA',
    'Mandiri',
    'BRI',
    'BNI',
    'CIMB Niaga',
  ];

  // Method to generate Virtual Account number
  String _generateVirtualAccount(String bank) {
    String bankCode = '';
    switch (bank) {
      case 'BCA':
        bankCode = 'BCA';
        break;
      case 'Mandiri':
        bankCode = 'MAND';
        break;
      case 'BRI':
        bankCode = 'BRI';
        break;
      case 'BNI':
        bankCode = 'BNI';
        break;
      case 'CIMB Niaga':
        bankCode = 'CIMB';
        break;
      default:
        bankCode = 'UNKNOWN';
    }

    // Generate a random number as part of the VA code (e.g., 8 digits)
    String randomNumber =
        (Random().nextInt(90000000) + 10000000).toString(); // Random 8 digits

    return '$bankCode-$randomNumber'; // Combine bank code with random number
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Top Up',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Exit the current page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.grey[200], // Background color for the form
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Kolom Nama Pengguna
                Container(
                  color: Colors.white, // Color for form fields
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Pengguna',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Colors.blue[900]),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama pengguna tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _namaPengguna = value ?? '';
                    },
                  ),
                ),
                SizedBox(height: 16),

                // Kolom Nomor Rekening
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nomor Rekening',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.account_balance, color: Colors.blue[900]),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor rekening tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _nomorRekening = value ?? '';
                    },
                  ),
                ),
                SizedBox(height: 16),

                // Kolom Pilih Bank
                Container(
                  color: Colors.white,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Pilih Bank',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.credit_card, color: Colors.blue[900]),
                    ),
                    value: _bank.isEmpty ? null : _bank,
                    onChanged: (String? newValue) {
                      setState(() {
                        _bank = newValue ?? '';
                        // Generate Virtual Account number when the bank is selected
                        if (_bank.isNotEmpty) {
                          _virtualAccount = _generateVirtualAccount(_bank);
                        }
                      });
                    },
                    items: _bankOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilih bank yang valid';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),

                // Kolom Jumlah Top Up
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: topupController,
                    decoration: InputDecoration(
                      labelText: 'Jumlah Top Up',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.attach_money, color: Colors.blue[900]),
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah top up tidak boleh kosong';
                      }
                      if (double.tryParse(value) == null ||
                          double.parse(value) <= 0) {
                        return 'Masukkan jumlah top up yang valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // topupController.text = double.tryParse(value ?? '') ?? 0.0;
                    },
                  ),
                ),
                SizedBox(height: 16),

                // Virtual Account Number Display
                if (_virtualAccount.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          'Virtual Account: $_virtualAccount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 24),

                // Tombol Top Up with an Icon (Pinjam / Loan Icon)
                Container(
                  width: double.infinity, // Full width to match form fields
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: Icon(
                      Icons
                          .account_balance_wallet, // Icon for the top up action
                      color: Colors.white,
                    ),
                    label: Text(
                      'Top Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue[900], // Set button color to blue
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk submit form
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      UserService userService = UserService();
      userService.addBalance(double.tryParse(topupController.text) ?? 0);
      // Tampilkan dialog untuk konfirmasi pengiriman uang
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text(
              'Apakah Anda yakin ingin melakukan top up sebesar Rp ${topupController.text} ke akun $_namaPengguna\nBank: $_bank\nNomor Rekening: $_nomorRekening\nVirtual Account: $_virtualAccount',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  // Aksi top up dilakukan di sini
                  Navigator.of(context).pop();
                  _showSuccessDialog();
                },
                child: Text('Top Up'),
              ),
            ],
          );
        },
      );
    }
  }

  // Dialog sukses setelah top up
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Top Up Berhasil'),
          content: Text(
              'Top up sebesar Rp ${topupController.text} telah berhasil dilakukan ke akun $_namaPengguna melalui Virtual Account $_virtualAccount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
