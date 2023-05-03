import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxString _username = ''.obs;
  final RxString _password = ''.obs;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void setUsername(String value) {
    _username.value = value;
  }

  void setPassword(String value) {
    _password.value = value;
  }

  void login() {
    // Implement your login logic here
    debugPrint('Logging in with username: $_username, password: $_password');
  }
}
