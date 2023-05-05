import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/controller/category_controller.dart';
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

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );

    debugPrint(
      "A User's Categories are: ${categoryController.groupModel.length}",
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
                      itemCount: categoryController.groupModel.length,
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
                              debugPrint(
                                  categoryController.groupModel[index].name);
                              Get.to(
                                () => TransactionView(
                                  categories:
                                      categoryController.groupModel[index].name,
                                ),
                              );
                            },
                            leading: Image.network(
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                            ),

                            // leading: Icon(categories[index]['icon']),
                            title:
                                Text(categoryController.groupModel[index].name),
                            // subtitle: Text(categoryController.groupModel[index].name),
                            trailing: Text(
                              categoryController.groupModel[index].id
                                  .toString(),
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
