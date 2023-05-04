import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final TextStyle titleStyle = TextStyle(
      fontSize: responsiveValues['titleFontSize']!,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(box.read('loginResponse').toString()),
            ),
            SizedBox(height: responsiveValues['verticalSpacing']!),
            Center(
              child: Text(box.read('registerResponse').toString()),
            ),
            TextButton(
              onPressed: () {
                box.remove('loginResponse');
                box.remove('registerResponse');

                Get.to(() => LoginView());
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
