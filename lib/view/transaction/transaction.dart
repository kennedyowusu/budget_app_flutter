import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/transaction_controller.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/notFound/empty_category.dart';
import 'package:budget_app_flutter/view/transaction/new_transaction.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_loader.dart';
import 'package:budget_app_flutter/widgets/custom_toast.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionView extends StatelessWidget {
  TransactionView({super.key, this.categoryName});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String? categoryName;

  final TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontSize: responsiveValues['titleFontSize']! - 6.0,
          fontWeight: FontWeight.bold,
        );

    debugPrint(
      "A User's Transactions are: ${transactionController.transactionModel.length}",
    );

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
                        trailing: Text(
                          'amount',
                        ),
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
                                  await transactionController
                                      .fetchTransaction();
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
                                            Dismissible(
                                      key: Key(transactionController
                                          .transactionModel[index].id
                                          .toString()),
                                      onDismissed: (direction) async {
                                        if (index >=
                                            transactionController
                                                .transactionModel.length) {
                                          return;
                                        }

                                        await transactionController
                                            .deleteUserTransaction(
                                          transactionController
                                              .transactionModel[index].id!,
                                        );

                                        await transactionController
                                            .fetchTransaction();

                                        ToastWidget.showToast(
                                          "Transaction Deleted Successfully",
                                        );
                                      },
                                      background: Container(
                                        color: Colors.red,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 16.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        height: responsiveValues[
                                            'containerHeight']!,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                  .transactionModel[index]
                                                  .amount
                                                  .toString(),
                                              style: bodyStyle,
                                            ),
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
                // Get.toNamed('/new-transaction');
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
