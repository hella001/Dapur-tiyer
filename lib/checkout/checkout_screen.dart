import 'package:flutter/material.dart';
import 'package:shop/checkout/components/body.dart';
import 'components/CheckoutCard.dart';

//import 'components/body.dart';

class checkoutScreen extends StatelessWidget {
  static String routeName = "/checkout";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Checkout",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
