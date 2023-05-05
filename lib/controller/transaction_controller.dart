import 'package:budget_app_flutter/controller/category_list.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final RxString currentRoute = ''.obs;

  final GlobalKey<FormState> transactionFormKey = GlobalKey<FormState>();

  final CategoryListController categoryList = Get.put(CategoryListController());

  final RxBool isLoading = false.obs;
  final RxString transactionName = "".obs;
  final RxString transactionIconLink = "".obs;

  TextEditingController transactionNameController = TextEditingController();
  TextEditingController transactionPriceController = TextEditingController();

  void setCurrentRoute(String route) {
    currentRoute.value = route;
  }

  @override
  void onClose() {
    transactionNameController.dispose();
    transactionPriceController.dispose();
    super.onClose();
  }

  void setTransactionName(String value) {
    transactionName.value = value;
  }

  void setTransactionIconLink(String value) {
    transactionIconLink.value = value;
  }

  bool isFormValid() {
    return transactionName.value.isNotEmpty &&
        transactionIconLink.value.isNotEmpty;
  }

  String? validateTransactionName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter transaction name';
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

  String? validateTransactionIconLink(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter transaction Icon link";
    }

    final uri = Uri.tryParse(value);
    if (uri == null || !uri.isAbsolute) {
      return "Please enter a valid URL";
    }

    return null;
  }

  String? validateTransactionPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter transaction price';
    }

    if (!GetUtils.isNumericOnly(value)) {
      return 'Please enter only digits';
    }

    return null;
  }


  Future<void> saveTransaction() async {
    if (transactionFormKey.currentState!.validate() && isFormValid()) {
      try {
        isLoading(true);

        final String transactionName = transactionNameController.text.trim();
        final String transactionIcon = transactionPriceController.text.trim();
        final String selectedCategory = categoryList.selectedCategory.value;

        debugPrint("Trans data are: $transactionName && $transactionIcon");
        debugPrint("Selected category: $selectedCategory");
      } catch (e) {
        isLoading.value = false;
        ToastWidget.showToast(e.toString());
        debugPrint('Transaction not sent: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      ToastWidget.showToast('Please enter valid transaction credentials');
    }
  }
}
