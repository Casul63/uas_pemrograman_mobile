import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_pemmob/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX App',
      initialRoute: '/kasir',
      getPages: AppRoutes.routes,
    );
  }
}
