import 'package:dashky_finance/screen/dashboard2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'listnasabah.dart'; // Replace with your actual List Nasabah Page
import 'profile2.dart'; // Replace with your actual ProfilePage

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF0D47A1),
        fontFamily: 'Roboto',
      ),
      home: ListLaporanPage(),
    );
  }
}

class Laporan {
  String title;
  String description;
  String date;

  Laporan(this.title, this.description, this.date);

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      json['title'],
      json['description'],
      json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }
}

class ListLaporanPage extends StatefulWidget {
  @override
  _ListLaporanPageState createState() => _ListLaporanPageState();
}

class _ListLaporanPageState extends State<ListLaporanPage> {
  List<Laporan> laporanList = [];
  int _selectedBottomTabIndex = 2; // Set to 2 to highlight Laporan tab by default

  @override
  void initState() {
    super.initState();
    _loadLaporanList();
  }

  Future<void> _saveLaporanList() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(laporanList.map((laporan) => laporan.toJson()).toList());
    await prefs.setString('laporanList', encodedData);
  }

  Future<void> _loadLaporanList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('laporanList');
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      setState(() {
        laporanList =
            decodedData.map((json) => Laporan.fromJson(json)).toList();
      });
    }
  }

  void _showAddOrEditLaporanDialog({Laporan? laporan, int? index}) {
    TextEditingController titleController = TextEditingController(
        text: laporan != null ? laporan.title : '');
    TextEditingController descriptionController = TextEditingController(
        text: laporan != null ? laporan.description : '');
    TextEditingController dateController = TextEditingController(
        text: laporan != null ? laporan.date : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            laporan == null ? "Tambah Laporan" : "Edit Laporan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Judul Laporan",
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Tanggal",
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());  // Prevent the keyboard from showing
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: laporan != null ? DateTime.parse(laporan.date) : DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (selectedDate != null) {
                      dateController.text = "${selectedDate.toLocal()}".split(' ')[0];  // Format it as YYYY-MM-DD
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  setState(() {
                    if (laporan == null) {
                      laporanList.add(Laporan(
                        titleController.text,
                        descriptionController.text,
                        dateController.text,
                      ));
                    } else {
                      laporanList[index!] = Laporan(
                        titleController.text,
                        descriptionController.text,
                        dateController.text,
                      );
                    }
                  });
                  _saveLaporanList();
                  Navigator.of(context).pop();
                }
              },
              child: Text(laporan == null ? "Tambah" : "Simpan"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text(
              "Apakah Anda yakin ingin menghapus laporan \"${laporanList[index].title}\"?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  laporanList.removeAt(index);
                });
                _saveLaporanList();
                Navigator.of(context).pop();
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  void _onBottomTabSelected(int index) {
    setState(() {
      _selectedBottomTabIndex = index;
    });
    // Switch to the selected page based on the index
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard2Page()), // Navigate to HomePage
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListNasabahPage()), // Navigate to ListNasabahPage
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListLaporanPage()), // Stay on ListLaporanPage (Current Page)
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen2()), // Navigate to ProfilePage
      );
    }
  }

  Future<void> _generatePdfAndPrint() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Laporan List', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              ...laporanList.map(
                (laporan) => pw.Padding(
                  padding: pw.EdgeInsets.symmetric(vertical: 5),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Judul: ${laporan.title}', style: pw.TextStyle(fontSize: 18)),
                      pw.Text('Deskripsi: ${laporan.description}', style: pw.TextStyle(fontSize: 16)),
                      pw.Text('Tanggal: ${laporan.date}', style: pw.TextStyle(fontSize: 16)),
                      pw.SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Laporan",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0D47A1),
        elevation: 4,
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: laporanList.isEmpty
          ? Center(
              child: Text(
                "Belum ada laporan",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: laporanList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        Icons.assignment,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      laporanList[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text("Deskripsi: ${laporanList[index].description}"),
                        Text("Tanggal: ${laporanList[index].date}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue[900]),
                          onPressed: () => _showAddOrEditLaporanDialog(
                              laporan: laporanList[index], index: index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteConfirmationDialog(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddOrEditLaporanDialog(),
        label: Text(
          "Tambah Laporan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue[900],
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
            icon: Icon(Icons.list_alt),
            label: 'List Nasabah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      persistentFooterButtons: [
        TextButton.icon(
          icon: Icon(Icons.print, color: Colors.blue),
          label: Text("Cetak Laporan", style: TextStyle(color: Colors.blue)),
          onPressed: _generatePdfAndPrint,
        ),
      ],
    );
  }
}
