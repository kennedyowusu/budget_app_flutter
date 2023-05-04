import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_radius.dart';
import 'package:budget_app_flutter/widgets/custom_text_field.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryView extends StatelessWidget {
  NewCategoryView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontSize: responsiveValues['titleFontSize']! - 3.0,
          fontWeight: FontWeight.bold,
        );
    return Scaffold(
      appBar: CustomAppBar(
        title: "New Category",
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(height: responsiveValues['verticalSpacing']!),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(responsiveValues['horizontalSpacing']!),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: responsiveValues['verticalSpacing']!),
                    LogoContainer(
                      radius: 50.0,
                    ),
                    SizedBox(height: responsiveValues['verticalSpacing']! * 5),
                    CustomTextField(
                      labelText: 'Category Name',
                    ),
                    SizedBox(height: 16.0),
                    CustomTextField(
                      labelText: 'Category Icon Link',
                    ),
                    SizedBox(height: 16.0),
                    CustomButton(
                      text: "Create Category",
                      onPressed: () {},
                      height: responsiveValues['buttonHeight']!,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => HomeView());
              },
              child: CustomBottomSheet(
                titleStyle: titleStyle,
                text: "Back Categories",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
