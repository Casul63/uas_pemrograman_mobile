import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            onTap: () {
              Get.toNamed('/dashboard');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Kasir'),
            onTap: () {
              Get.toNamed('/kasir');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Get.offAllNamed(
                  '/'); // Navigasi ke halaman login dan menghapus semua rute sebelumnya
            },
          ),
        ],
      ),
    );
  }
}
