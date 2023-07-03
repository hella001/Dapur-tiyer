import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/components/product_card.dart';
import 'package:shop/models/Product.dart';
import 'package:http/http.dart' as http;

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  Future<List<Product>> getProduct() async {
    // Uri url = Uri.parse('http://10.0.2.2:8000/api/products');
    Uri url = Uri.parse('http://kuropo.my.id/api/products');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
      // Map<String, dynamic> data = jsonResponse
      //     .map((item) => Map<String, dynamic>.from(item))
      //     .toList()[0];
      print(jsonResponse);
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
          child: SectionTitle(title: "Produk Populer", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ...List.generate(
            //   demoProducts.length,
            //   (index) {
            //     if (demoProducts[index].isPopular)
            //       return ProductCard(product: demoProducts[index]);

            //     return SizedBox
            //         .shrink(); // here by default width and height is 0
            //   },
            // ),

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
            ),
          ],
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
      ],
    );
  }
}
