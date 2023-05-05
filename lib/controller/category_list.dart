import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  CategoryListController();

  final RxBool isLoading = false.obs;
  final RxString selectedCategory = 'Option 1'.obs;

  final RxString currentRoute = ''.obs;

  final GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();

  final RxString categoryName = "".obs;
  final RxString categoryIconLink = "".obs;

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryIconController = TextEditingController();

  void setCurrentRoute(String route) {
    currentRoute.value = route;
  }

  @override
  void onClose() {
    categoryNameController.dispose();
    categoryIconController.dispose();
    super.onClose();
  }

  void setCategoryName(String value) {
    categoryName.value = value;
  }

  void setCategoryIconLink(String value) {
    categoryIconLink.value = value;
  }

  void toggleSelectedCategory(String newValue) {
    selectedCategory.value = newValue;
  }

  bool isFormValid() {
    return categoryName.isNotEmpty && categoryIconLink.isNotEmpty;
  }

  String? validateCategoryName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    if (value.length > 50) {
      return 'Name must not exceed 50 characters';
    }
    if (GetUtils.isNumericOnly(value)) {
      return 'Name must not contain numbers';
    }
    return null;
  }

  String? validateCategoryIconLink(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter Icon link";
    }

    final uri = Uri.tryParse(value);
    if (uri == null || !uri.isAbsolute) {
      return "Please enter a valid URL";
    }

    return null;
  }

  Future<void> saveCategory() async {
    if (categoryFormKey.currentState!.validate() && isFormValid()) {
      try {
        isLoading(true);

        final String categoryName = categoryNameController.text.trim();
        final String categoryIcon = categoryIconController.text.trim();

        debugPrint("Category data are: $categoryName && $categoryIcon");
      } catch (e) {
        isLoading.value = false;
        ToastWidget.showToast(e.toString());
        debugPrint('Transaction not sent: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      ToastWidget.showToast('Please enter valid category credentials');
    }
  }
}
