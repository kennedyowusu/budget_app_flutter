import 'package:budget_app_flutter/constants/colors.dart';
import 'package:flutter/material.dart';

class BuildFooterSection extends StatelessWidget {
  const BuildFooterSection({
    super.key,
    required this.responsiveValues,
    required this.onPressed,
    required this.text,
    required this.subText,
  });

  final Map<String, double> responsiveValues;
  final VoidCallback onPressed;
  final String text, subText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        SizedBox(width: responsiveValues['horizontalSpacing']! * 0.5),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            subText,
            style: TextStyle(
              color: mainColor,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
