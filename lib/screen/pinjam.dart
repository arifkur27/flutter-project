import 'package:flutter/material.dart';
import 'dart:math';

class LoanApplicationPage extends StatefulWidget {
  @override
  _LoanApplicationPageState createState() => _LoanApplicationPageState();
}

class _LoanApplicationPageState extends State<LoanApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  String _namaPengguna = '';
  String _nomorRekening = '';
  String _bank = '';
  String _loanAccount = ''; // Loan Account field
  double _jumlahPinjaman = 0.0;

  // List of bank options for the user to select
  final List<String> _bankOptions = [
    'BCA',
    'Mandiri',
    'BRI',
    'BNI',
    'CIMB Niaga',
  ];

  // Method to generate Loan Account number
  String _generateLoanAccount(String bank) {
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

    // Generate a random number as part of the loan account code (e.g., 8 digits)
    String randomNumber = (Random().nextInt(90000000) + 10000000).toString(); // Random 8 digits

    return '$bankCode-$randomNumber'; // Combine bank code with random number
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengajuan Pinjaman',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[900], // Blue app bar
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
          color: Colors.white, // White background for the form
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Kolom Nama Pengguna
                Container(
                  color: Colors.white, // Color for form fields
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      labelStyle: TextStyle(color: Colors.blue[900]), // Blue label
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Colors.blue[900]), // Blue icon
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama lengkap tidak boleh kosong';
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
                      labelStyle: TextStyle(color: Colors.blue[900]), // Blue label
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.account_balance, color: Colors.blue[900]), // Blue icon
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
                      labelStyle: TextStyle(color: Colors.blue[900]), // Blue label
                      border: OutlineInputBorder(),
                    ),
                    value: _bank.isEmpty ? null : _bank,
                    onChanged: (String? newValue) {
                      setState(() {
                        _bank = newValue ?? '';
                        // Generate Loan Account number when the bank is selected
                        if (_bank.isNotEmpty) {
                          _loanAccount = _generateLoanAccount(_bank);
                        }
                      });
                    },
                    items: _bankOptions.map<DropdownMenuItem<String>>((String value) {
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

                // Kolom Jumlah Pinjaman
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Jumlah Pinjaman',
                      labelStyle: TextStyle(color: Colors.blue[900]), // Blue label
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.blue[900]), // Blue icon
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah pinjaman tidak boleh kosong';
                      }
                      if (double.tryParse(value) == null || double.parse(value) <= 0) {
                        return 'Masukkan jumlah pinjaman yang valid';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _jumlahPinjaman = double.tryParse(value ?? '') ?? 0.0;
                    },
                  ),
                ),
                SizedBox(height: 16),

                // Loan Account Number Display
                if (_loanAccount.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Text(
                      'Nomor Akun Pinjaman: $_loanAccount',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900], // Blue color for loan account number
                      ),
                    ),
                  ),
                SizedBox(height: 24),

                // Tombol Ajukan Pinjaman
                Container(
                  width: double.infinity, // Full width to match form fields
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Ajukan Pinjaman',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900], // Set button color to blue
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

      // Tampilkan dialog untuk konfirmasi pengajuan pinjaman
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text(
              'Apakah Anda yakin ingin mengajukan pinjaman sebesar Rp $_jumlahPinjaman ke akun $_namaPengguna\nBank: $_bank\nNomor Rekening: $_nomorRekening\nNomor Akun Pinjaman: $_loanAccount',
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
                  // Aksi pinjaman dilakukan di sini
                  Navigator.of(context).pop();
                  _showSuccessDialog();
                },
                child: Text('Ajukan'),
              ),
            ],
          );
        },
      );
    }
  }

  // Dialog sukses setelah pengajuan pinjaman
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pinjaman Berhasil'),
          content: Text('Pinjaman sebesar Rp $_jumlahPinjaman telah berhasil diajukan ke akun $_namaPengguna melalui Nomor Akun Pinjaman $_loanAccount.'),
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
