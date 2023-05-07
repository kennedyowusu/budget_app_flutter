import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/category_controller.dart';
import 'package:budget_app_flutter/controller/transaction_controller.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/notFound/empty_category.dart';
import 'package:budget_app_flutter/view/transaction/new_transaction.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_loader.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionView extends StatelessWidget {
  TransactionView({super.key, this.categoryName, required this.groupId});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String? categoryName;
  final int groupId;

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontSize: responsiveValues['titleFontSize']! - 6.0,
          fontWeight: FontWeight.bold,
        );

    final TransactionController transactionController =
        Get.put(TransactionController(groupId: groupId));

    return Scaffold(
      backgroundColor: backgroundColor,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "Transaction",
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveValues['horizontalSpacing']!,
              ),
              child: Column(
                children: [
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  Container(
                    height: responsiveValues['containerHeight']! + 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/1828/1828884.png",
                          height: 40,
                          width: 40,
                        ),
                        title: Text(
                          categoryName ?? " Name",
                        ),
                        trailing: Obx(() {
                          double totalAmount = 0.0;
                          for (var transaction
                              in transactionController.transactionModel) {
                            totalAmount += transaction.amount.toString() == ""
                                ? 0.0
                                : double.parse(
                                    transaction.amount,
                                  );
                          }
                          return Text(
                            totalAmount.toStringAsFixed(2),
                            style: titleStyle.copyWith(
                              color: textColor,
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  Obx(
                    () => transactionController.isLoading.value
                        ? Center(
                            child: LoadingWidget(),
                          )
                        : transactionController.transactionModel.isEmpty
                            ? Center(
                                child: EmptyCategory(
                                  title: "No Transaction Found",
                                  iconData: Icons.money_off,
                                  description:
                                      "You have not added any transaction yet",
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  await transactionController.fetchTransactions(
                                    transactionController
                                        .transactionModel.first.id,
                                  );
                                },
                                child: Expanded(
                                  child: ListView.separated(
                                    itemCount: transactionController
                                        .transactionModel.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        Divider(),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                      height:
                                          responsiveValues['containerHeight']!,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: ListTile(
                                          onTap: () {
                                            debugPrint(
                                              "Transaction ID is: ${transactionController.transactionModel[index].id}",
                                            );
                                          },
                                          title: Text(
                                            transactionController
                                                .transactionModel[index].name,
                                            style: bodyStyle,
                                          ),
                                          subtitle: Text(
                                            'date',
                                          ),
                                          trailing: Text(
                                            transactionController
                                                .transactionModel[index].amount
                                                .toString(),
                                            style: bodyStyle,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => NewTransactionView());
                transactionController.setCurrentRoute('/new-transaction');
              },
              child: CustomBottomSheet(
                titleStyle: titleStyle,
                text: "Add New Transaction",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
