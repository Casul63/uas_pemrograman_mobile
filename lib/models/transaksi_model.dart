class TransaksiModel {
  final int id;
  final String nama;
  final double harga;
  final DateTime waktuTransaksi;

  TransaksiModel({
    required this.id,
    required this.nama,
    required this.harga,
    required this.waktuTransaksi,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'waktuTransaksi': waktuTransaksi.toIso8601String(),
    };
  }

  factory TransaksiModel.fromMap(Map<String, dynamic> map) {
    return TransaksiModel(
      id: map['id'],
      nama: map['nama'],
      harga: map['harga'],
      waktuTransaksi: DateTime.parse(map['waktuTransaksi']),
    );
  }
}
