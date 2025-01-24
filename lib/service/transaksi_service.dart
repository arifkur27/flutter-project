import 'package:dashky_finance/models/transaksi_model.dart';

class TransaksiService {
  static List<Transaksi> transaksiList = [];

  // Add Transaksi
  static Future<void> addTransaksi(Transaksi transaksi) async {
    transaksiList.add(transaksi);
  }

  // Update Transaksi
  static Future<void> updateTransaksi(String id, Transaksi transaksi) async {
    final index = transaksiList.indexWhere((t) => t.id == id);
    if (index != -1) {
      transaksiList[index] = transaksi;
    }
  }

  // Delete Transaksi
  static Future<void> deleteTransaksi(String id) async {
    transaksiList.removeWhere((t) => t.id == id);
  }

  // Get All Transaksi
  static Future<List<Transaksi>> getAllTransaksi() async {
    return transaksiList;
  }
}
