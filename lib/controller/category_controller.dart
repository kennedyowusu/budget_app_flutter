import 'package:budget_app_flutter/model/group.dart';
import 'package:budget_app_flutter/services/category/category.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryService categoryService = CategoryService();
  final RxList<GroupModel> groupModel = <GroupModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    getUsersCategory();
    super.onInit();
  }

  Future<void> getUsersCategory() async {
    try {
      isLoading(true);
      GroupModelResponse groupModelResponse =
          await categoryService.fetchCategories();
      groupModel.assignAll(groupModelResponse.data);
      debugPrint("Group model ${groupModelResponse.data}");
      debugPrint("Total Groups/Categories for this User: ${groupModel.length}");
    } catch (e) {
      isLoading(false);
      debugPrint("Error fetching a user's category: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> createUserCategory() async {}
}
