import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:budget_app_flutter/controller/category_list.dart';
import 'package:budget_app_flutter/model/transaction.dart';
import 'package:budget_app_flutter/services/transactions/transacton.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';

class TransactionController extends GetxController {
  final TransactionService transactionService = TransactionService();
  final RxList<TransactionModel> transactionModel = <TransactionModel>[].obs;
  final RxString currentRoute = ''.obs;

  final GlobalKey<FormState> transactionFormKey = GlobalKey<FormState>();

  final CategoryListController categoryList = Get.put(CategoryListController());

  final RxBool isLoading = false.obs;
  final RxString transactionName = "".obs;
  final RxString transactionAmount = "".obs;

  int groupId;

  TransactionController({required this.groupId});

  TextEditingController transactionNameController = TextEditingController();
  TextEditingController transactionAmountController = TextEditingController();

  void setCurrentRoute(String route) {
    currentRoute.value = route;
  }

  @override
  void onInit() {
    fetchTransactions(groupId);
    super.onInit();
  }

  @override
  void onClose() {
    transactionNameController.dispose();
    transactionAmountController.dispose();
    super.onClose();
  }

  void setTransactionName(String value) {
    transactionName.value = value;
  }

  void setTransactionAmount(String value) {
    transactionAmount.value = value;
  }

  bool isFormValid() {
    return transactionName.value.isNotEmpty &&
        transactionAmount.value.isNotEmpty;
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

  Future<void> saveTransaction(
    int id,
  ) async {
    if (transactionFormKey.currentState!.validate() && isFormValid()) {
      try {
        isLoading(true);

        final String transactionName = transactionNameController.text.trim();
        final String transactionAmount =
            transactionAmountController.text.trim();
        final String selectedCategory = categoryList.selectedCategory.value;

        final response = await transactionService.createTransaction(
            transactionName, transactionAmount, id);

        debugPrint(
          'Category Response: ${response.data.toString()}',
        );

        debugPrint(
          'Category Response: ${response.data}',
        );

        resetTransactionForm();

        debugPrint("Trans data are: $transactionName && $transactionAmount");
        debugPrint("Selected category: $selectedCategory");
      } catch (e) {
        isLoading.value = false;
        ToastWidget.showToast(e.toString());
        debugPrint('Transaction not Created: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      ToastWidget.showToast('Please enter valid transaction credentials');
    }
  }

  void resetTransactionForm() {
    transactionNameController.clear();
    transactionAmountController.clear();
    categoryList.resetSelectedCategory();
  }

  Future<void> fetchTransactions(int groupId) async {
    try {
      isLoading.value = true;

      final TransactionModelResponse transactionResponse =
          await transactionService.getTransactions(groupId);

      transactionModel.assignAll(transactionResponse.data);

      debugPrint("Group ID passed to fetchTransaction is: $groupId");

      debugPrint(
        "Total Transactions for Group': ${transactionModel.length}",
      );

      debugPrint(
        "Fetched transactions are: ${transactionResponse.data.length}",
      );

      debugPrint(
        "Total Transactions for this User: ${transactionModel.length}",
      );
    } catch (e) {
      isLoading.value = false;
      ToastWidget.showToast(e.toString());
      debugPrint('Transactions not fetched: $e');
    } finally {
      isLoading.value = false;
      debugPrint("Transactions in the list: ${transactionModel.length}");
    }
  }

  Future deleteUserTransaction(int id) async {
    try {
      isLoading(true);

      await transactionService.deleteTransaction(id);
      debugPrint("Delete transaction");
    } catch (e) {
      isLoading.value = false;
      debugPrint('Transaction not deleted: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
