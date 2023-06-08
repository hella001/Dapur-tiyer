import 'package:flutter/material.dart';
//import 'package:shop/account_setting/components/body.dart';

import 'components/body.dart';

class ServiceCenter extends StatelessWidget {
  static String routeName = "/service_center";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Bantuan",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
