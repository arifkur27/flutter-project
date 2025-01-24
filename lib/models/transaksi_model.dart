class Transaksi {
  String? id;
  String userId;
  double jumlahTransaksi;
  String jenisTransaksi; // "debit" atau "kredit"
  DateTime tanggalTransaksi;

  Transaksi({
    this.id,
    required this.userId,
    required this.jumlahTransaksi,
    required this.jenisTransaksi,
    required this.tanggalTransaksi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'jumlahTransaksi': jumlahTransaksi,
      'jenisTransaksi': jenisTransaksi,
      'tanggalTransaksi': tanggalTransaksi.toIso8601String(),
    };
  }

  factory Transaksi.fromMap(Map<String, dynamic> map) {
    return Transaksi(
      id: map['id'],
      userId: map['userId'],
      jumlahTransaksi: map['jumlahTransaksi'],
      jenisTransaksi: map['jenisTransaksi'],
      tanggalTransaksi: DateTime.parse(map['tanggalTransaksi']),
    );
  }
}
