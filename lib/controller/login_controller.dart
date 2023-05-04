import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void setUsername(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  bool isFormValid() {
    return email.isNotEmpty && password.isNotEmpty;
  }

  void login() {
    if (loginFormKey.currentState!.validate() && isFormValid()) {
      // Implement your login logic here
      debugPrint('Logging in with username: $email, password: $password');

      // Clear input fields after successful login
      emailController.clear();
      passwordController.clear();
    } else {
      ToastWidget.showToast('Please enter valid credentials');
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }

    // Add additional email validation logic if needed

    return null; // Return null if validation succeeds
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Add additional password validation logic if needed

    return null; // Return null if validation succeeds
  }
}
