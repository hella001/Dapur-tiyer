import 'package:flutter/material.dart';
import 'package:shop/all_menu/menu_screen.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MenuScreen.routeName);
          },
          child: Text(
            "Lihat semua",
            style: TextStyle(color: Color(0xFFBBBBBB)),
          ),
        ),
      ],
    );
  }
}
