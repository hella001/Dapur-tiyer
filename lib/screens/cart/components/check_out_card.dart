import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/checkout/checkout_screen.dart';
import 'package:shop/components/default_button.dart';
import 'package:shop/models/Cart.dart';
//import 'package:shop/checkout/checkout_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shop/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
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
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),*/
            SizedBox(height: getProportionateScreenHeight(20)),
            FutureBuilder(
              future: getCarts(),
              builder: (context, snapshot) {
                if (snapshot.data!.isNotEmpty) {
                  final List<int> variantList = [];
                  for (var i = 0; i < snapshot.data!.length; i++) {
                    variantList.add(snapshot.data![i].harga!.toInt());
                  }
                  var sum =
                      variantList.reduce((value, current) => value + current);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text: "Rp.${sum.toString()}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(190),
                        child: DefaultButton(
                          text: "Bayar",
                          press: () {
                            /*const snackdemo = SnackBar(
                              content: Text('Pembayaran berhasil'),
                              backgroundColor: Colors.green,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );*/
                            Navigator.pushNamed(
                                context, checkoutScreen.routeName);
                            ScaffoldMessenger.of(context);
                            //#Perubahan
                            // .showSnackBar(snackdemo);

                            // 'showSnackBar' is deprecated and shouldn't be used.
                            //Use ScaffoldMessenger.showSnackBar.
                            // Scaffold.of(context).showSnackBar(snackdemo);
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text: "Rp.0",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(190),
                        child: DefaultButton(
                          text: "Bayar",
                          press: () {
                            const snackdemo = SnackBar(
                              content: Text('Tidak ada Item'),
                              backgroundColor: Colors.red,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            // Navigator.pushNamed(context, HomeScreen.routeName);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackdemo);

                            // 'showSnackBar' is deprecated and shouldn't be used.
                            //Use ScaffoldMessenger.showSnackBar.
                            // Scaffold.of(context).showSnackBar(snackdemo);
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
