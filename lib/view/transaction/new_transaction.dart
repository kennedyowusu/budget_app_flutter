import 'package:budget_app_flutter/widgets/new_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'transaction.dart';

class NewTransactionView extends StatelessWidget {
  NewTransactionView({super.key});

  int groupId = 0;

  final GlobalKey<FormState> transactionFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String currentRoute = Get.currentRoute;
    debugPrint("Current route is $currentRoute");
    return NewFormView(
      title: "New Transaction",
      buttonText: "Create Transaction",
      onPressed: () {
        debugPrint('hello');
      },
      backText: "Back Transaction",
      onBack: () {
        Get.to(() => TransactionView(groupId: groupId));
      },
    );
  }
}
