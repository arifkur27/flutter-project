import 'package:dashky_finance/models/angsuran_model.dart';

class AngsuranService {
  static List<Angsuran> angsuranList = [];

  // Add Angsuran
  static Future<void> addAngsuran(Angsuran angsuran) async {
    angsuranList.add(angsuran);
  }

  // Update Angsuran
  static Future<void> updateAngsuran(String id, Angsuran angsuran) async {
    final index = angsuranList.indexWhere((a) => a.id == id);
    if (index != -1) {
      angsuranList[index] = angsuran;
    }
  }

  // Delete Angsuran
  static Future<void> deleteAngsuran(String id) async {
    angsuranList.removeWhere((a) => a.id == id);
  }

  // Get All Angsuran
  static Future<List<Angsuran>> getAllAngsuran() async {
    return angsuranList;
  }
}
