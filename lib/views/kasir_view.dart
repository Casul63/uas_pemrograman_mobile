import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kasir_controller.dart';
import '../components/app_drawer.dart';

class KasirView extends StatelessWidget {
  final kasirController = Get.put(KasirController());
  final namaController = TextEditingController();
  final hargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kasir')),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: hargaController,
              decoration: InputDecoration(labelText: 'Harga Produk'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Menampilkan daftar barang yang ditambahkan
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: kasirController.barangs.length,
                  itemBuilder: (context, index) {
                    final barang = kasirController.barangs[index];
                    return Card(
                      color: Colors.grey[200],
                      child: ListTile(
                        title: Text(
                            '${barang.nama} = Rp ${barang.harga.toStringAsFixed(2)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                namaController.text = barang.nama;
                                hargaController.text = barang.harga.toString();
                                kasirController.setEditMode(barang.id);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                kasirController.removeBarang(barang.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                final nama = namaController.text;
                final harga = double.tryParse(hargaController.text) ?? 0;

                if (nama.isNotEmpty && harga > 0) {
                  if (kasirController.isEditMode.value != -1) {
                    kasirController.updateBarang(
                        kasirController.isEditMode.value, nama, harga);
                  } else {
                    kasirController.addBarang(nama, harga);
                  }
                  namaController.clear();
                  hargaController.clear();
                  kasirController.setEditMode(-1); // Reset to no edit mode
                } else {
                  Get.snackbar('Error', 'Nama atau harga tidak valid');
                }
              },
              child: Text(
                  kasirController.isEditMode.value == -1 ? 'Tambah' : 'Update'),
            ),
            SizedBox(height: 20),
            // Tombol Selesaikan Transaksi
            ElevatedButton(
              onPressed: () async {
                if (kasirController.barangs.isEmpty) {
                  Get.snackbar('Error', 'Tidak ada barang untuk transaksi');
                } else {
                  kasirController.selesaiTransaksi(); // Selesaikan transaksi
                  Get.snackbar(
                      'Transaksi Selesai', 'Transaksi telah diselesaikan!');
                }
              },
              child: Text('Selesaikan Transaksi'),
            ),
          ],
        ),
      ),
    );
  }
}
