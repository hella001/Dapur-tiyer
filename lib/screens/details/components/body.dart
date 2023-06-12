import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/components/default_button.dart';
import 'package:shop/models/Default.dart';
import 'package:shop/models/Product.dart';
import 'package:shop/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  final String id;
  final String image;
  final String title;
  final String deskripsi;
  final int harga;

  const Body({
    Key? key,
    required this.id,
    required this.image,
    required this.title,
    required this.deskripsi,
    required this.harga,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<void> addToCart(String BarangId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? membersId = prefs.getInt('membersId');
      final url = "http://10.0.2.2:8000/api/carts";

      var requestBody = {
        'id_member': membersId.toString(),
        'id_barang': BarangId,
        'jumlah': 1.toString(),
        'size': 'XL',
        'color': "Default",
        'total': widget.harga.toString(),
        'is_checkout': "0",
      };

      http.Response response =
          await http.post(Uri.parse(url), body: requestBody);

      var data = jsonDecode(response.body);
      if (data["status"] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(
          id: widget.id.toString(),
          image: widget.image.toString(),
        ),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                title: widget.title.toString(),
                deskripsi: widget.deskripsi.toString(),
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {
                            addToCart(widget.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
