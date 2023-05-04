import 'package:budget_app_flutter/services/auth/register.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final RegisterService _signupService = RegisterService();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void setName(String value) {
    name.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  void setConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  bool isFormValid() {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password.value == confirmPassword.value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    // if (!GetUtils.isAlphabetOnly(value)) {
    //   return 'Name must contain only alphabets';
    // }
    if (GetUtils.isNumericOnly(value)) {
      return 'Name must not contain numbers';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (value.length > 50) {
      return 'Password must not exceed 50 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (value.length > 50) {
      return 'Password must not exceed 50 characters';
    } else if (value != password.value) {
      return 'Passwords do not match';
    }
    return null;
  }

  void signUp() {
    if (!isFormValid()) {
      ToastWidget.showToast('Please enter valid credentials');
      return;
    }

    if (signupFormKey.currentState!.validate() && isFormValid()) {
      // Implement your sign up logic here
      try {
        isLoading.value = true;

        final String name = nameController.text.trim();
        final String email = emailController.text.trim();
        final String password = passwordController.text.trim();
        final String confirmPassword = confirmPasswordController.text.trim();

        _signupService.register(name, email, password, confirmPassword);

        Get.offAll(
          () => HomeView(),
        );

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        ToastWidget.showToast(e.toString());
      } finally {
        isLoading.value = false;
      }
      debugPrint(
        'Signing up with name: $name, email: $email, password: $password, confirmPassword: $confirmPassword',
      );

      // Clear input fields after successful sign up
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    } else {
      ToastWidget.showToast('Please enter valid credentials');
    }
  }
}
