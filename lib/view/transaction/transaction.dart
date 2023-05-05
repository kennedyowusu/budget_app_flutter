import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/transaction_controller.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/transaction/new_transaction.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionView extends StatelessWidget {
  TransactionView({super.key, this.categories});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final categories;

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
                          'name',
                        ),
                        trailing: Text(
                          'amount',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: responsiveValues['verticalSpacing']!),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 5,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        height: responsiveValues['containerHeight']!,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              // debugPrint(categories[index]['name']);
                            },
                            // leading: CircleAvatar(
                            //   backgroundColor: Colors.white,
                            //   child: Icon(
                            //     categories[index]['icon'],
                            //     color: Colors.black,
                            //   ),
                            // ),
                            title: Text(
                              'name',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),

                            subtitle: Text(
                              'date',
                            ),
                            trailing: Text(
                              "amount",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
