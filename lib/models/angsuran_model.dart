class Angsuran {
  String? id;
  String pinjamanId;
  double jumlahAngsuran;
  DateTime tanggalAngsuran;

  Angsuran({
    this.id,
    required this.pinjamanId,
    required this.jumlahAngsuran,
    required this.tanggalAngsuran,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pinjamanId': pinjamanId,
      'jumlahAngsuran': jumlahAngsuran,
      'tanggalAngsuran': tanggalAngsuran.toIso8601String(),
    };
  }

  factory Angsuran.fromMap(Map<String, dynamic> map) {
    return Angsuran(
      id: map['id'],
      pinjamanId: map['pinjamanId'],
      jumlahAngsuran: map['jumlahAngsuran'],
      tanggalAngsuran: DateTime.parse(map['tanggalAngsuran']),
    );
  }
}
