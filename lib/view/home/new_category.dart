import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/view/transaction/transaction.dart';
import 'package:budget_app_flutter/widgets/new_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryView extends StatelessWidget {
  const NewCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return NewFormView(
      title: "New Category",
      buttonText: "Create Category",
      onPressed: () {},
      backText: "Back Categories",
      onBack: () {
        Get.to(() => HomeView());
      },
    );
  }
}

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
