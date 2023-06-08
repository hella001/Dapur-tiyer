import 'package:flutter/material.dart';
import 'package:shop/components/coustom_bottom_nav_bar.dart';
import 'package:shop/enums.dart';

import 'components/body.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = "/menu";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.message),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Menu",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
