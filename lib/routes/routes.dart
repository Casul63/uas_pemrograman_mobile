import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/kasir_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => LoginView()),
    GetPage(name: '/dashboard', page: () => DashboardView()),
    GetPage(name: '/kasir', page: () => KasirView()),
  ];
}
