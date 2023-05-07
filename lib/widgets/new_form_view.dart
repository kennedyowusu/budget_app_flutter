import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/category_list.dart';
import 'package:budget_app_flutter/controller/profile_controller.dart';
import 'package:budget_app_flutter/controller/transaction_controller.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/view/transaction/transaction.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_loader.dart';
import 'package:budget_app_flutter/widgets/custom_radius.dart';
import 'package:budget_app_flutter/widgets/custom_text_field.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:budget_app_flutter/widgets/list_of_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewFormView extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  final String backText;
  final VoidCallback onBack;
  int? groupId;

  NewFormView({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
    required this.backText,
    required this.onBack,
  });

  final CategoryListController categoryController =
      Get.put(CategoryListController());

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final TransactionController transactionController =
        Get.put(TransactionController(groupId: groupId!));

    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontSize: responsiveValues['titleFontSize']! - 3.0,
          fontWeight: FontWeight.bold,
        );

    final String currentRoute = transactionController.currentRoute.value;
    final GlobalKey<FormState> formKey = currentRoute == '/new-transaction'
        ? transactionController.transactionFormKey
        : categoryController.categoryFormKey;

    // String currentRoute = Get.currentRoute;
    debugPrint("Current route is $currentRoute");

    final userId = profileController.userProfileModel.value.id;
    debugPrint("User Id from the Form UI: $userId");

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: title,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(height: responsiveValues['verticalSpacing']!),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(responsiveValues['horizontalSpacing']!),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: responsiveValues['verticalSpacing']!),
                      LogoContainer(
                        radius: 50.0,
                      ),
                      SizedBox(
                          height: responsiveValues['verticalSpacing']! * 5),
                      CustomTextField(
                        labelText: transactionController.currentRoute.value ==
                                '/new-transaction'
                            ? 'Transaction Name'
                            : 'Category Name',
                        controller: transactionController.currentRoute.value ==
                                '/new-transaction'
                            ? transactionController.transactionNameController
                            : categoryController.categoryNameController,
                        validator: (value) => transactionController
                                    .currentRoute.value ==
                                '/new-transaction'
                            ? transactionController
                                .validateTransactionName(value)
                            : categoryController.validateCategoryName(value),
                        onChanged: (value) => transactionController
                                    .currentRoute.value ==
                                '/new-transaction'
                            ? transactionController.setTransactionName(value)
                            : categoryController.setCategoryName(value),
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField(
                        labelText: transactionController.currentRoute.value ==
                                '/new-transaction'
                            ? 'Transaction Price'
                            : 'Category Icon Link',
                        controller: transactionController.currentRoute.value ==
                                '/new-transaction'
                            ? transactionController.transactionAmountController
                            : categoryController.categoryIconController,
                        validator: (value) =>
                            transactionController.currentRoute.value ==
                                    '/new-transaction'
                                ? transactionController
                                    .validateTransactionPrice(value)
                                : categoryController
                                    .validateCategoryIconLink(value),
                        onChanged: (value) => transactionController
                                    .currentRoute.value ==
                                '/new-transaction'
                            ? transactionController.setTransactionAmount(value)
                            : categoryController.setCategoryIconLink(value),
                      ),
                      Obx(() {
                        if (transactionController.currentRoute.value ==
                            '/new-transaction') {
                          return Column(
                            children: [
                              SizedBox(height: 16.0),
                              Text(
                                'Select Category',
                                style: bodyStyle,
                              ),
                              SizedBox(height: 16.0),
                              Container(
                                height:
                                    responsiveValues['verticalSpacing']! * 2.5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  border: Border.all(
                                    color: Colors.grey.shade500,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Center(
                                  child: CategoryListWidget(),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }),
                      SizedBox(height: 16.0),
                      Obx(
                        () => transactionController.isLoading.value
                            ? LoadingWidget()
                            : CustomButton(
                                text: buttonText,
                                onPressed: () {
                                  transactionController.currentRoute.value ==
                                          '/new-transaction'
                                      ? debugPrint("Transaction")
                                      : debugPrint("Category");

                                  transactionController.currentRoute.value ==
                                          '/new-transaction'
                                      ? transactionController.saveTransaction(
                                          profileController
                                              .userProfileModel.value.id!,
                                        )
                                      : categoryController.saveCategory(
                                          profileController
                                              .userProfileModel.value.id!,
                                        );

                                  transactionController.currentRoute.value ==
                                          '/new-transaction'
                                      ? transactionController
                                          .transactionFormKey.currentState!
                                          .reset()
                                      : categoryController
                                          .categoryFormKey.currentState!
                                          .reset();

                                  transactionController.currentRoute.value ==
                                          '/new-transaction'
                                      ? Get.to(() => TransactionView())
                                      : Get.to(() => HomeView());
                                },
                                height: responsiveValues['buttonHeight']!,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onBack,
              child: CustomBottomSheet(
                titleStyle: titleStyle,
                text: backText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
