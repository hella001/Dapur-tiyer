import 'package:flutter/material.dart';
import 'package:shop/all_menu/components/menu.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AllMenu(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
