import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'dashboard2.dart';
import 'profile2.dart';
import 'laporanpage.dart'; // Import the LaporanPage

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
      home: ListNasabahPage(),
    );
  }
}

class Nasabah {
  String name;
  String address;
  String phone;
  String type;

  Nasabah(this.name, this.address, this.phone, this.type);

  factory Nasabah.fromJson(Map<String, dynamic> json) {
    return Nasabah(
      json['name'],
      json['address'],
      json['phone'],
      json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'phone': phone,
      'type': type,
    };
  }
}

class ListNasabahPage extends StatefulWidget {
  @override
  _ListNasabahPageState createState() => _ListNasabahPageState();
}

class _ListNasabahPageState extends State<ListNasabahPage> {
  List<Nasabah> nasabahList = [];
  int _selectedBottomTabIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadNasabahList();
  }

  Future<void> _saveNasabahList() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(nasabahList.map((nasabah) => nasabah.toJson()).toList());
    await prefs.setString('nasabahList', encodedData);
  }

  Future<void> _loadNasabahList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('nasabahList');
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      setState(() {
        nasabahList =
            decodedData.map((json) => Nasabah.fromJson(json)).toList();
      });
    }
  }

  void _showAddOrEditNasabahDialog({Nasabah? nasabah, int? index}) {
    TextEditingController nameController = TextEditingController(
        text: nasabah != null ? nasabah.name : '');
    TextEditingController addressController = TextEditingController(
        text: nasabah != null ? nasabah.address : '');
    TextEditingController phoneController = TextEditingController(
        text: nasabah != null ? nasabah.phone : '');
    String? selectedType = nasabah?.type;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            nasabah == null ? "Tambah Nasabah" : "Edit Nasabah",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nama Nasabah",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: "Nomor Telepon",
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: InputDecoration(
                    labelText: "Jenis Nasabah",
                    prefixIcon: Icon(Icons.category),
                    border: OutlineInputBorder(),
                  ),
                  items: ["Individu", "Perusahaan"]
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
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
                if (nameController.text.isNotEmpty &&
                    addressController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    selectedType != null) {
                  setState(() {
                    if (nasabah == null) {
                      nasabahList.add(Nasabah(
                        nameController.text,
                        addressController.text,
                        phoneController.text,
                        selectedType!,
                      ));
                    } else {
                      nasabahList[index!] = Nasabah(
                        nameController.text,
                        addressController.text,
                        phoneController.text,
                        selectedType!,
                      );
                    }
                  });
                  _saveNasabahList();
                  Navigator.of(context).pop();
                }
              },
              child: Text(nasabah == null ? "Tambah Nasabah" : "Simpan"),
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
              "Apakah Anda yakin ingin menghapus nasabah ${nasabahList[index].name}?"),
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
                  nasabahList.removeAt(index);
                });
                _saveNasabahList();
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
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard2Page()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen2()),
      );
    } else if (index == 2) {
      // Navigate to LaporanPage when "Laporan" tab is selected
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListLaporanPage()), // Navigate to LaporanPage
      );
    } else {
      setState(() {
        _selectedBottomTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Manajemen Keanggotaan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF0D47A1),
          elevation: 4,
        ),
      ),
      body: nasabahList.isEmpty
          ? Center(
              child: Text(
                "Belum ada data nasabah",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: nasabahList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[900],
                      child: Icon(
                        nasabahList[index].type == "Individu"
                            ? Icons.person
                            : Icons.business,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      nasabahList[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text("Alamat: ${nasabahList[index].address}"),
                        Text("Telepon: ${nasabahList[index].phone}"),
                        Text("Jenis: ${nasabahList[index].type}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue[900]),
                          onPressed: () => _showAddOrEditNasabahDialog(
                              nasabah: nasabahList[index], index: index),
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
        onPressed: () => _showAddOrEditNasabahDialog(),
        label: Text(
          "Tambah Anggota",
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
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
