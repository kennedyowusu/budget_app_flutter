import 'package:budget_app_flutter/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(mainColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        maximumSize: MaterialStateProperty.all<Size>(Size.fromHeight(50.0)),
        minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(50.0)),
        elevation: MaterialStateProperty.all<double>(0.0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        ),
      ),
      child: Text(
        text,
        style: subtitleStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
