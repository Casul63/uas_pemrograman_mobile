import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLogged = false.obs;

  void login(String username, String password) {
    if (username == 'admin' && password == 'password') {
      isLogged.value = true;
      Get.offAllNamed('/dashboard');
    } else if (username == '' || password == '') {
      Get.snackbar('Error', 'Username dan Password harus diisi');
    } else {
      Get.snackbar('Error', 'Username atau Password salah');
    }
  }
}
