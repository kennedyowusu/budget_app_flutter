import 'package:budget_app_flutter/constants/colors.dart';
import 'package:budget_app_flutter/view/home/home.dart';
import 'package:budget_app_flutter/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final GetStorage box = GetStorage();
  final currentRoute = Get.currentRoute;

  @override
  Widget build(BuildContext context) {
    debugPrint("currentRoute: $currentRoute");
    Container container = Container(
      height: 1,
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.only(left: 70),
    );
    return Drawer(
      backgroundColor: mainColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: mainColor,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Drawer Header',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.home),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              if (Get.currentRoute != '/home') {
                Get.offAll(() => HomeView());
              } else {
                Navigator.pop(context);
              }
            },
          ),
          container,
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              if (Get.currentRoute != '/profile') {
                Get.offAll(() => ProfileView());
              } else {
                Navigator.pop(context);
              }
            },
          ),
          container,
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.monetization_on),
            ),
            title: Text(
              'Budget',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          container,
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(Icons.location_on),
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          container,
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              if (Get.currentRoute != '/login') {
                // box.erase();
                box.remove('loginResponse');
                Get.offAllNamed('/login');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          container,
        ],
      ),
    );
  }
}
