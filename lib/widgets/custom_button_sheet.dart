import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.titleStyle,
    required this.text,
  });

  final TextStyle titleStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: secondaryColor,
        height: calculateResponsiveValues(context)['bottomSheetHeight']!,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 100.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: Text(
              text,
              style: titleStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
