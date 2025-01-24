import 'package:flutter/material.dart';

class BayarPage extends StatefulWidget {
  @override
  _BayarPageState createState() => _BayarPageState();
}

class _BayarPageState extends State<BayarPage> {
  final _formKey = GlobalKey<FormState>();
  String _namaPenerima = '';
  String _nomorRekening = '';
  String _bank = '';
  double _jumlahUang = 0.0;

  // Saldo awal
  double _saldoSimpanan = 1000000.0; // Misal saldo awal 1 juta

  // List of bank options for the user to select
  final List<String> _bankOptions = [
    'BCA',
    'Mandiri',
    'BRI',
    'BNI',
    'CIMB Niaga',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Pembayaran',
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
                // Kolom Nama Penerima
                Container(
                  color: Colors.white, // Color for form fields
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nama Penerima',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: Colors.blue[900]), // Icon for name field
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama penerima tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _namaPenerima = value ?? '';
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
                      prefixIcon: Icon(Icons.account_balance, color: Colors.blue[900]), // Icon for account number field
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
                    ),
                    value: _bank.isEmpty ? null : _bank,
                    onChanged: (String? newValue) {
                      setState(() {
                        _bank = newValue ?? '';
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

                // Kolom Jumlah Uang
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Jumlah Uang',
                      labelStyle: TextStyle(color: Colors.blue[900]),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money, color: Colors.blue[900]), // Icon for money amount field
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Jumlah uang tidak boleh kosong';
                      }
                      double? parsedAmount = double.tryParse(value);
                      if (parsedAmount == null || parsedAmount <= 0) {
                        return 'Masukkan jumlah uang yang valid';
                      }
                      if (parsedAmount > _saldoSimpanan) {
                        return 'Saldo Anda tidak cukup';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _jumlahUang = double.tryParse(value ?? '') ?? 0.0;
                    },
                  ),
                ),
                SizedBox(height: 24),

                // Tombol Kirim
                Container(
                  width: double.infinity, // Full width to match form fields
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text(
                      'Kirim',
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
      
      // Cek jika saldo cukup
      if (_jumlahUang > _saldoSimpanan) {
        // Tampilkan dialog jika saldo tidak cukup
        _showSaldoInsufficientDialog();
        return;
      }

      // Tampilkan dialog untuk konfirmasi pengiriman uang
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: Text(
              'Apakah Anda yakin ingin mengirim uang sebesar Rp $_jumlahUang ke $_namaPenerima\nBank: $_bank\nNomor Rekening: $_nomorRekening',
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
                  // Kurangi saldo setelah pengiriman
                  setState(() {
                    _saldoSimpanan -= _jumlahUang;
                  });
                  Navigator.of(context).pop();
                  _showSuccessDialog();
                },
                child: Text('Kirim'),
              ),
            ],
          );
        },
      );
    }
  }

  // Dialog sukses setelah kirim uang
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transaksi Berhasil'),
          content: Text('Uang sebesar Rp $_jumlahUang telah berhasil dikirim ke $_namaPenerima.\nSaldo Anda sekarang: Rp $_saldoSimpanan'),
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

  // Dialog jika saldo tidak cukup
  void _showSaldoInsufficientDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Saldo Tidak Cukup'),
          content: Text('Saldo Anda tidak cukup untuk melakukan transaksi sebesar Rp $_jumlahUang.'),
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
}
