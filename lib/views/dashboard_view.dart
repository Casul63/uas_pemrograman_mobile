import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:uas_pemmob/components/app_drawer.dart';
import '../controllers/kasir_controller.dart';
import '../models/transaksi_model.dart';

class DashboardView extends StatelessWidget {
  final kasirController = Get.put(KasirController());

  // Fungsi untuk menghitung total penjualan dari transaksi
  double getTotalPenjualan(List<TransaksiModel> transaksiList) {
    double total = 0.0;
    for (var transaksi in transaksiList) {
      total += transaksi.harga;
    }
    return total;
  }

  List<FlSpot> getGrafikPenjualan(List<TransaksiModel> transaksiList) {
    List<FlSpot> spots = [];
    for (int i = 0; i < transaksiList.length; i++) {
      spots.add(FlSpot((i + 1).toDouble(), transaksiList[i].harga));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Penjualan'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ringkasan Penjualan
            Obx(() {
              final transaksiList = kasirController.transaksiList;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Penjualan: Rp ${getTotalPenjualan(transaksiList).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Jumlah Barang: ${transaksiList.length}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                ],
              );
            }),

            // Grafik Penjualan
            Obx(() {
              final transaksiList = kasirController.transaksiList;
              return Container(
                height: 300,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    minX: 1,
                    maxX: transaksiList.length.toDouble(),
                    minY: 0,
                    maxY: transaksiList.isNotEmpty
                        ? transaksiList
                            .map((e) => e.harga)
                            .reduce((a, b) => a > b ? a : b)
                        : 0,
                    lineBarsData: [
                      LineChartBarData(
                        spots: getGrafikPenjualan(transaksiList),
                        isCurved: true,
                        color: Colors.blue,
                        belowBarData: BarAreaData(
                            show: true, color: Colors.blue.withOpacity(0.3)),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
