import 'package:budget_app_flutter/widgets/new_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'transaction.dart';

class NewTransactionView extends StatelessWidget {
  const NewTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return NewFormView(
      title: "New Transaction",
      buttonText: "Create Transaction",
      onPressed: () {},
      backText: "Back Transaction",
      onBack: () {
        Get.to(() => TransactionView());
      },
    );
  }
}
