import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/authentication/login.dart';
import 'package:budget_app_flutter/view/authentication/sign_up.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(
                child: Text(
                  'Your Money Your Way'.toUpperCase(),
                  style: titleStyle,
                ),
              ),
              Spacer(),
              CustomButton(
                height: responsiveValues['buttonHeight']!,
                text: 'Login',
                onPressed: () {
                  Get.offAll(() => LoginView());
                },
              ),
              SizedBox(height: 10.0),
              CustomButton(
                height: responsiveValues['buttonHeight']!,
                text: 'Sign Up',
                onPressed: () {
                  Get.offAll(() => SignUpView());
                },
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
