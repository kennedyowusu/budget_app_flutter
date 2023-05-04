import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/%20signup_controller.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/authentication/login.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:budget_app_flutter/widgets/custom_footer_section.dart';
import 'package:budget_app_flutter/widgets/custom_loader.dart';
import 'package:budget_app_flutter/widgets/custom_radius.dart';
import 'package:budget_app_flutter/widgets/custom_text.dart';
import 'package:budget_app_flutter/widgets/custom_text_field.dart';
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
            child: Form(
              key: _signupController.signupFormKey,
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
                    validator: (value) => _signupController.validateName(value),
                    key: Key('name'),
                    controller: _signupController.nameController,
                    labelText: 'Full Name',
                    onChanged: (value) => _signupController.setName(value),
                    height: responsiveValues['textFieldHeight']!,
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  CustomTextField(
                    validator: (value) =>
                        _signupController.validateEmail(value),
                    key: Key('email'),
                    controller: _signupController.emailController,
                    labelText: 'Email Address',
                    onChanged: (value) => _signupController.setEmail(value),
                    height: responsiveValues['textFieldHeight']!,
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  CustomTextField(
                    validator: (value) =>
                        _signupController.validatePassword(value),
                    key: Key('password'),
                    controller: _signupController.passwordController,
                    labelText: 'Password',
                    obscureText: true,
                    onChanged: (value) => _signupController.setPassword(value),
                    height: responsiveValues['textFieldHeight']!,
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  CustomTextField(
                    validator: (value) =>
                        _signupController.validateConfirmPassword(value),
                    key: Key('confirmPassword'),
                    controller: _signupController.confirmPasswordController,
                    labelText: 'Confirm Password',
                    obscureText: true,
                    onChanged: (value) =>
                        _signupController.setConfirmPassword(value),
                    height: responsiveValues['textFieldHeight']!,
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                  Obx(
                    () => _signupController.isLoading.value
                        ? LoadingWidget()
                        : CustomButton(
                            text: 'Register',
                            onPressed: () {
                              _signupController.signUp();
                            },
                            height: responsiveValues['buttonHeight']!,
                          ),
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                  BuildFooterSection(
                    responsiveValues: responsiveValues,
                    onPressed: () {
                      Get.to(() => LoginView());
                    },
                    text: 'Already have an account?',
                    subText: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
