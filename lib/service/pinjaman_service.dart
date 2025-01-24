import 'package:dashky_finance/models/pinjaman_models.dart';

class PinjamanService {
  static List<Pinjaman> pinjamanList = [];

  // Add Pinjaman
  static Future<void> addPinjaman(Pinjaman pinjaman) async {
    pinjamanList.add(pinjaman);
  }

  // Update Pinjaman
  static Future<void> updatePinjaman(String id, Pinjaman pinjaman) async {
    final index = pinjamanList.indexWhere((p) => p.id == id);
    if (index != -1) {
      pinjamanList[index] = pinjaman;
    }
  }

  // Delete Pinjaman
  static Future<void> deletePinjaman(String id) async {
    pinjamanList.removeWhere((p) => p.id == id);
  }

  // Get All Pinjaman
  static Future<List<Pinjaman>> getAllPinjaman() async {
    return pinjamanList;
  }
}
