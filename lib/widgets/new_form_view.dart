import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_radius.dart';
import 'package:budget_app_flutter/widgets/custom_text_field.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:budget_app_flutter/widgets/list_of_categories.dart';
import 'package:flutter/material.dart';

class NewFormView extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  final String backText;
  final VoidCallback onBack;

  const NewFormView({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
    required this.backText,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontSize: responsiveValues['titleFontSize']! - 3.0,
          fontWeight: FontWeight.bold,
        );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: title,
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
                      labelText: 'Transaction Name',
                    ),
                    SizedBox(height: 16.0),
                    CustomTextField(
                      labelText: 'Transaction Icon Link',
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      textAlign: TextAlign.start,
                      'Select Category',
                      style: bodyStyle,
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      height: responsiveValues['verticalSpacing']! * 2.5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(
                          color: Colors.grey.shade500,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: CategoryListWidget(),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    CustomButton(
                      text: buttonText,
                      onPressed: onPressed,
                      height: responsiveValues['buttonHeight']!,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onBack,
              child: CustomBottomSheet(
                titleStyle: titleStyle,
                text: backText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
