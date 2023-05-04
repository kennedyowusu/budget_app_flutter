import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/login_controller.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/authentication/sign_up.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:budget_app_flutter/widgets/custom_footer_section.dart';
import 'package:budget_app_flutter/widgets/custom_loader.dart';
import 'package:budget_app_flutter/widgets/custom_radius.dart';
import 'package:budget_app_flutter/widgets/custom_text.dart';
import 'package:budget_app_flutter/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  static const routeName = '/login';

  LoginView({Key? key}) : super(key: key);

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
              key: _loginController.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: 'Welcome Back',
                      style: titleStyle,
                    ),
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                  LogoContainer(
                    radius: MediaQuery.of(context).size.width * 0.15,
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                  CustomTextField(
                    key: Key('email'),
                    controller: _loginController.emailController,
                    validator: (value) => _loginController.validateEmail(value),
                    labelText: 'Email Address',
                    onChanged: (value) => _loginController.setUsername(value),
                    height: responsiveValues['textFieldHeight']!,
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  CustomTextField(
                    key: Key('password'),
                    controller: _loginController.passwordController,
                    validator: (value) =>
                        _loginController.validatePassword(value),
                    labelText: 'Password',
                    obscureText: true,
                    onChanged: (value) => _loginController.setPassword(value),
                    height: responsiveValues['textFieldHeight']!,
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                  Obx(
                    () => _loginController.isLoading.value
                        ? LoadingWidget()
                        : CustomButton(
                            text: 'Login',
                            onPressed: () {
                              _loginController.login();
                            },
                            height: responsiveValues['buttonHeight']!,
                          ),
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']! * 2),
                  BuildFooterSection(
                    responsiveValues: responsiveValues,
                    onPressed: () {
                      Get.to(() => SignUpView());
                    },
                    text: 'Don\'t have an account?',
                    subText: 'Sign Up',
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
