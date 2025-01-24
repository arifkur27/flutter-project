class Pinjaman {
  String? id;
  String userId;
  double jumlahPinjaman;
  double bunga;
  DateTime tanggalPinjaman;
  String status; // contoh: "lunas", "belum lunas"

  Pinjaman({
    this.id,
    required this.userId,
    required this.jumlahPinjaman,
    required this.bunga,
    required this.tanggalPinjaman,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'jumlahPinjaman': jumlahPinjaman,
      'bunga': bunga,
      'tanggalPinjaman': tanggalPinjaman.toIso8601String(),
      'status': status,
    };
  }

  factory Pinjaman.fromMap(Map<String, dynamic> map) {
    return Pinjaman(
      id: map['id'],
      userId: map['userId'],
      jumlahPinjaman: map['jumlahPinjaman'],
      bunga: map['bunga'],
      tanggalPinjaman: DateTime.parse(map['tanggalPinjaman']),
      status: map['status'],
    );
  }
}
