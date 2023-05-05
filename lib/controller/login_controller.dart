import 'package:budget_app_flutter/services/auth/login.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  final RxBool isLoading = false.obs;

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

  Future<void> login() async {
    if (loginFormKey.currentState!.validate() && isFormValid()) {
      try {
        isLoading.value = true;

        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        final response = await _loginService.login(email, password);

        debugPrint("$response");

        // Handle successful login, e.g., navigate to home screen
        // or perform additional logic based on the response
        Get.offAll(
          () => HomeView(),
        );
        debugPrint(
          "Login successful: Email is $email, $password",
        );

        // Clear email and password fields after successful login

        emailController.clear();
        passwordController.clear();
      } catch (e) {
        // Handle login failure, e.g., display error message
        isLoading.value = false;
        ToastWidget.showToast(e.toString());
        debugPrint('Login failed: $e');
      } finally {
        isLoading.value = false;
      }
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
