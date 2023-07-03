import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/Cart.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/Default.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<CartsModel>> getCarts() async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();

    Uri url = Uri.parse(
        // 'http://10.0.2.2:8000/api/carts/${statusLogin.getInt('membersId')}');
        'http://kuropo.my.id/api/carts/${statusLogin.getInt('membersId')}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse.map((e) => CartsModel.fromJson(e)).toList();
    } else {
      throw Exception('Error!');
    }
  }

  Future<void> deleteCard(String id) async {
    var cardid = id;
    try {
      http.Response response = await http
          // .get(Uri.parse('http://10.0.2.2:8000/api/carts/delete/$cardid'));
          .get(Uri.parse('http://kuropo.my.id/api/carts/delete/$cardid'));

      var data = jsonDecode(response.body);
      print("CartID: $cardid Status: " + data["status"].toString());
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
      print("Error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: FutureBuilder(
        future: getCarts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Dismissible(
                  key: Key(data![index].cartsId.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      deleteCard(data[index].cartsId.toString());
                    }

                    // print(data![index].cartsId!.toInt());
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: CartCard(
                      images: data[index].gambar.toString(),
                      harga: data[index].harga!.toDouble(),
                      jumlah: data[index].jumlah!.toInt(),
                      nama_produk: data[index].namaBarang.toString()),
                ),
              ),
            );
          } else {
            return Text('Data kosong!!');
          }
        },
      ),
    );
  }
}
