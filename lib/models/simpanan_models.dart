class Simpanan {
  String? id;
  String userId;
  double jumlahSimpanan;
  DateTime tanggalSimpanan;

  Simpanan({
    this.id,
    required this.userId,
    required this.jumlahSimpanan,
    required this.tanggalSimpanan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'jumlahSimpanan': jumlahSimpanan,
      'tanggalSimpanan': tanggalSimpanan.toIso8601String(),
    };
  }

  factory Simpanan.fromMap(Map<String, dynamic> map) {
    return Simpanan(
      id: map['id'],
      userId: map['userId'],
      jumlahSimpanan: map['jumlahSimpanan'],
      tanggalSimpanan: DateTime.parse(map['tanggalSimpanan']),
    );
  }
}
