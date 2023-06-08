import 'package:flutter/material.dart';
//import 'package:shop/account_setting/components/form_setting_account.dart';
import 'package:shop/account_setting/components/body.dart';

import 'components/body.dart';

class AccountSetting extends StatelessWidget {
  static String routeName = "/account_setting";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Setting akun",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
