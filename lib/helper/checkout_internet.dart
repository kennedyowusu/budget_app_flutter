import 'package:budget_app_flutter/view/authentication/login.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> checkInternetConnectivity(BuildContext context) async {
  ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    Fluttertoast.showToast(
      msg: 'Still no internet connection',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  } else {
    Fluttertoast.showToast(
      msg: 'Internet connection restored',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );

    final box = GetStorage();
    final token = box.read('token') ?? '';

    if (token.isNotEmpty) {
      Get.off(
        () => HomeView(),
      );
    } else {
      Get.off(
        () => LoginView(),
      );
    }
  }
}
