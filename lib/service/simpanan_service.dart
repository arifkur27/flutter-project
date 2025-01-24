import 'package:dashky_finance/models/simpanan_models.dart';

class SimpananService {
  static List<Simpanan> simpananList = [];

  // Add Simpanan
  static Future<void> addSimpanan(Simpanan simpanan) async {
    simpananList.add(simpanan);
  }

  // Update Simpanan
  static Future<void> updateSimpanan(String id, Simpanan simpanan) async {
    final index = simpananList.indexWhere((s) => s.id == id);
    if (index != -1) {
      simpananList[index] = simpanan;
    }
  }

  // Delete Simpanan
  static Future<void> deleteSimpanan(String id) async {
    simpananList.removeWhere((s) => s.id == id);
  }

  // Get All Simpanan
  static Future<List<Simpanan>> getAllSimpanan() async {
    return simpananList;
  }
}
