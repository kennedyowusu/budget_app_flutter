import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/category_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListWidget extends StatelessWidget {
  CategoryListWidget({super.key});

  final CategoryList categoryList = Get.put(CategoryList());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: categoryList.selectedCategory.value,
          onChanged: (newValue) {
            categoryList.toggleSelectedCategory(newValue!);
          },
          items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  style: bodyStyle,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
