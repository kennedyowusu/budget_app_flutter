import 'package:budget_app_flutter/controller/category_list.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/widgets/new_form_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryView extends StatelessWidget {
  NewCategoryView({super.key});

  final GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  final CategoryListController categoryController =
      Get.put(CategoryListController());

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
