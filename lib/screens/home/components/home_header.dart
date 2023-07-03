import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/screens/cart/cart_screen.dart';
import 'package:http/http.dart' as http;

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  Future<List<CartsModel>> getCarts() async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        // 'http://10.0.2.2:8000/api/carts/${statusLogin.getInt('membersId')}');
        'http://kuropo.my.id/api/carts/${statusLogin.getInt('membersId')}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => CartsModel.fromJson(e)).toList();
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          /*IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),*/
          FutureBuilder(
            future: getCarts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  numOfitem: snapshot.data!.length,
                  press: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                );
              } else {
                return IconBtnWithCounter(
                  svgSrc: "assets/icons/Cart Icon.svg",
                  numOfitem: 0,
                  press: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
