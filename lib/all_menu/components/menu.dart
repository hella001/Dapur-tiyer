import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/components/product_card.dart';
import 'package:shop/models/Product.dart';
import 'package:http/http.dart' as http;

import '../../../size_config.dart';

class AllMenu extends StatefulWidget {
  @override
  State<AllMenu> createState() => _AllMenuState();
}

class _AllMenuState extends State<AllMenu> {
  Future<List<Product>> getProduct() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/api/products');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: 25,
              runSpacing: 15,
              children: [
                FutureBuilder(
                  future: getProduct(),
                  builder: (context, snapshot) {
                    var items = snapshot.data;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: items!.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                              id: items[index].id.toString(),
                              gambar: items[index].gambar.toString(),
                              nama_barang: items[index].namaBarang.toString(),
                              harga: items[index].harga!,
                              deskripsi: items[index].deskripsi.toString());
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              ],
            )
          ],
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
      ],
    );
  }
}
