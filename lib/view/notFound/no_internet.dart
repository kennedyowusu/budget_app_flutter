import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/helper/checkout_internet.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  final String message;

  const NoInternetScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  size: 200,
                  color: Colors.black,
                ),
                SizedBox(height: 26),
                Text(
                  message.toUpperCase(),
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                CustomButton(
                  text: 'Refresh',
                  onPressed: () {
                    checkInternetConnectivity(context);
                  },
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
