import 'package:budget_app_flutter/helper/calculate_responsiveness.dart';
import 'package:budget_app_flutter/view/home/new_category.dart';
import 'package:budget_app_flutter/widgets/custom_appbar.dart';
import 'package:budget_app_flutter/widgets/custom_button_sheet.dart';
import 'package:budget_app_flutter/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GetStorage box = GetStorage();

// List of objects
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Food",
      "icon": Icons.fastfood,
      "date": "04 Aug 2021",
      "price": "GHS2000.0"
    },
    {
      "name": "Transport",
      "icon": Icons.directions_car,
      "date": "07 Aug 2021",
      "price": "GHS2200.0"
    },
    {
      "name": "Shopping",
      "icon": Icons.shopping_cart,
      "date": "09 Aug 2021",
      "price": "GHS2500.0"
    },
    {
      "name": "Entertainment",
      "icon": Icons.movie,
      "date": "12 Aug 2021",
      "price": "GHS3000.0"
    },
    {
      "name": "Health",
      "icon": Icons.local_hospital,
      "date": "15 Aug 2021",
      "price": "GHS3500.0"
    },
    {
      "name": "Education",
      "icon": Icons.school,
      "date": "18 Aug 2021",
      "price": "GHS4000.0"
    },
    {
      "name": "Others",
      "icon": Icons.more_horiz,
      "date": "21 Aug 2021",
      "price": "GHS4500.0"
    },
    {
      "name": "Others",
      "icon": Icons.more_horiz,
      "date": "21 Aug 2021",
      "price": "GHS4500.0"
    },
    {
      "name": "Others",
      "icon": Icons.more_horiz,
      "date": "21 Aug 2021",
      "price": "GHS4500.0"
    }
  ];

  @override
  Widget build(BuildContext context) {
    final responsiveValues = calculateResponsiveValues(context);
    final titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
    return Scaffold(
      key: _scaffoldKey,
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
            Column(
              children: [
                SizedBox(height: responsiveValues['verticalSpacing']!),
                Expanded(
                  child: ListView.separated(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (BuildContext context, int index) => Container(
                      height: responsiveValues['containerHeight']!,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Image.network(
                            'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                          ),
                          // leading: Icon(categories[index]['icon']),
                          onTap: () {},
                          title: Text(categories[index]['name']),
                          subtitle: Text(categories[index]['date']),
                          trailing: Text(
                            categories[index]['price'],
                            style: TextStyle(
                              color: Colors.red,
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
