import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/%20signup_controller.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/authentication/login.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:budget_app_flutter/widgets/custom_radius.dart';
import 'package:budget_app_flutter/widgets/custom_text.dart';
import 'package:budget_app_flutter/widgets/custom_text_field.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final SignupController _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(responsiveValues['horizontalSpacing']!),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: responsiveValues['verticalSpacing']!),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Create Account',
                    style: titleStyle,
                  ),
                ),
                SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                LogoContainer(
                  radius: MediaQuery.of(context).size.width * 0.15,
                ),
                SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                CustomTextField(
                  key: Key('name'),
                  controller: _signupController.nameController,
                  labelText: 'Full Name',
                  onChanged: (value) => _signupController.setName(value),
                  height: responsiveValues['textFieldHeight']!,
                ),
                SizedBox(height: responsiveValues['verticalSpacing']!),
                CustomTextField(
                  key: Key('email'),
                  controller: _signupController.emailController,
                  labelText: 'Email Address',
                  onChanged: (value) => _signupController.setEmail(value),
                  height: responsiveValues['textFieldHeight']!,
                ),
                SizedBox(height: responsiveValues['verticalSpacing']!),
                CustomTextField(
                  key: Key('password'),
                  controller: _signupController.passwordController,
                  labelText: 'Password',
                  obscureText: true,
                  onChanged: (value) => _signupController.setPassword(value),
                  height: responsiveValues['textFieldHeight']!,
                ),
                SizedBox(height: responsiveValues['verticalSpacing']!),
                CustomTextField(
                  key: Key('confirmPassword'),
                  controller: _signupController.confirmPasswordController,
                  labelText: 'Confirm Password',
                  obscureText: true,
                  onChanged: (value) =>
                      _signupController.setConfirmPassword(value),
                  height: responsiveValues['textFieldHeight']!,
                ),
                SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    if (_signupController.name.value.isEmpty ||
                        _signupController.email.value.isEmpty ||
                        _signupController.password.value.isEmpty ||
                        _signupController.confirmPassword.value.isEmpty) {
                      ToastWidget.showToast('Please fill in all fields');
                      return;
                    } else if (_signupController.password.value !=
                        _signupController.confirmPassword.value) {
                      ToastWidget.showToast('Passwords do not match');
                      return;
                    }
                    _signupController.signUp();
                  },
                  height: responsiveValues['buttonHeight']!,
                ),
                SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    SizedBox(
                        width: responsiveValues['horizontalSpacing']! * 0.5),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => LoginView());
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
