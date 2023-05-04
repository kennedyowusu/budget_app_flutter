import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/data/categories.dart';
import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/home/new_category.dart';
import 'package:budget_app_flutter/view/transaction/transaction.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: "Category",
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      resizeToAvoidBottomInset: false,
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
                  Expanded(
                    child: ListView.separated(
                      itemCount: categories.length,
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
                              debugPrint(categories[index]['name']);
                              Get.to(
                                () => TransactionView(
                                  categories: categories[index]['name'],
                                ),
                              );
                            },
                            leading: Image.network(
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),

                            // leading: Icon(categories[index]['icon']),
                            title: Text(categories[index]['name']),
                            subtitle: Text(categories[index]['date']),
                            trailing: Text(
                              categories[index]['price'],
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsiveValues['verticalSpacing']!,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => NewCategoryView(),
                );
              },
              child: CustomBottomSheet(
                titleStyle: titleStyle,
                text: "Add New Category",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
