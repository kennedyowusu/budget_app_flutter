import 'package:get/get.dart';

class CategoryList extends GetxController {
  CategoryList();

  RxString selectedCategory = 'Option 1'.obs;

  void toggleSelectedCategory(String newValue) {
    selectedCategory.value = newValue;
  }
}
