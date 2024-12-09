import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/barang_model.dart';
import '../models/transaksi_model.dart';

class KasirController extends GetxController {
  var barangs = <BarangModel>[].obs;
  var transaksiList = <TransaksiModel>[].obs;
  var isEditMode = (-1).obs;

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> transaksiListMap =
        transaksiList.map((transaksi) => transaksi.toMap()).toList();
    await prefs.setString('transaksi', json.encode(transaksiListMap));
  }

  void addBarang(String nama, double harga) {
    int id = barangs.isEmpty ? 1 : barangs.last.id + 1;
    var barang = BarangModel(id: id, nama: nama, harga: harga);
    barangs.add(barang);
  }

  void removeBarang(int id) {
    barangs.removeWhere((barang) => barang.id == id);
  }

  void updateBarang(int id, String nama, double harga) {
    var barang = barangs.firstWhere((barang) => barang.id == id);
    barang.nama = nama;
    barang.harga = harga;
    barangs.refresh();
  }

  void setEditMode(int id) {
    isEditMode.value = id;
  }

  void selesaiTransaksi() {
    for (var barang in barangs) {
      var transaksi = TransaksiModel(
        id: transaksiList.length + 1,
        nama: barang.nama,
        harga: barang.harga,
        waktuTransaksi: DateTime.now(),
      );
      transaksiList.add(transaksi);
    }
    barangs.clear();
    _saveData();
  }

  double getTotalPenjualan() {
    return transaksiList.fold(0.0, (sum, transaksi) => sum + transaksi.harga);
  }
}
