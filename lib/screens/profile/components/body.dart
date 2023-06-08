import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/account_setting/account_setting_screen.dart';
import 'package:shop/screens/splash/splash_screen.dart';
import 'package:shop/service_center/service_center_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  void removePrefs() async {
    SharedPreferences status = await SharedPreferences.getInstance();
    status.remove('status');
    print(status.getInt('status'));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Akunku",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                {Navigator.pushNamed(context, AccountSetting.routeName)},
          ),
          /*ProfileMenu(
            text: "Notifikasi",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Pengaturan",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),*/
          ProfileMenu(
            text: "Bantuan",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.pushNamed(context, ServiceCenter.routeName);
            },
          ),
          ProfileMenu(
            text: "Keluar",
            icon: "assets/icons/Log out.svg",
            press: () {
              removePrefs();
              Navigator.pushNamed(context, SplashScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
