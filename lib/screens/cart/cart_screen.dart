import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/Cart.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<List<CartsModel>> getCarts() async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        'http://10.0.2.2:8000/api/carts/${statusLogin.getInt('membersId')}');

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
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Keranjang",
            style: TextStyle(color: Colors.black),
          ),
          FutureBuilder(
            future: getCarts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  "${snapshot.data!.length} items",
                  style: Theme.of(context).textTheme.caption,
                );
              } else {
                return Text(
                  "0 items",
                  style: Theme.of(context).textTheme.caption,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
