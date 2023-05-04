import 'package:budget_app_flutter/controller/theme.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/view/notFound/no_internet.dart';
import 'package:budget_app_flutter/view/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity/connectivity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  final GetStorage storage = GetStorage();
  storage.read("loginResponse");
  // box.remove('token');
  runApp(BudgetApp(isUserLoggedIn: storage.hasData('loginResponse')));
}

class BudgetApp extends StatefulWidget {
  const BudgetApp({super.key, required this.isUserLoggedIn});
  final bool isUserLoggedIn;

  @override
  State<BudgetApp> createState() => _BudgetAppState();
}

class _BudgetAppState extends State<BudgetApp> {
  bool hasInternetConnection = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  // This widget is the root of your application.

  Future<void> checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        hasInternetConnection = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (controller) {
        final currentTheme = controller.currentTheme.value;
        return GetMaterialApp(
          title: 'Budget App',
          debugShowCheckedModeBanner: false,
          transitionDuration: const Duration(milliseconds: 500),
          defaultTransition: Transition.fade,
          theme: currentTheme,
          home: hasInternetConnection
              ? widget.isUserLoggedIn
                  ? HomeView()
                  : SplashView()
              : NoInternetScreen(
                  message: 'No internet Connection',
                ),
        );
      },
    );
  }
}
