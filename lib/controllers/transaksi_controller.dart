import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/transaksi_model.dart';

class TransaksiController extends GetxController {
  var transaksiList = <TransaksiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadTransaksi();
  }

  // Load transaksi dari SharedPreferences
  void _loadTransaksi() async {
    final prefs = await SharedPreferences.getInstance();
    String? transaksiString = prefs.getString('transaksi');
    if (transaksiString != null) {
      List<dynamic> transaksiJson = json.decode(transaksiString);
      transaksiList.value = transaksiJson
          .map((transaksi) => TransaksiModel.fromMap(transaksi))
          .toList();
    }
  }

  // Menambahkan transaksi baru
  void addTransaksi(String nama, double harga) {
    final transaksi = TransaksiModel(
      id: transaksiList.length + 1,
      nama: nama,
      harga: harga,
      waktuTransaksi: DateTime.now(),
    );
    transaksiList.add(transaksi);
    _saveTransaksi();
  }

  // Menyimpan transaksi ke SharedPreferences
  void _saveTransaksi() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> transaksiJson =
        transaksiList.map((transaksi) => transaksi.toMap()).toList();
    await prefs.setString('transaksi', json.encode(transaksiJson));
  }

  // Menghitung total penjualan
  double getTotalPenjualan() {
    return transaksiList.fold(0.0, (sum, transaksi) => sum + transaksi.harga);
  }
}
