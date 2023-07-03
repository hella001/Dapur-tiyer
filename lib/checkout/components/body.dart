import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/checkout/components/CheckoutCard.dart';
import 'package:shop/components/default_button.dart';
import 'package:shop/models/Cart.dart';
import 'package:shop/models/Default.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../size_config.dart';

class body extends StatefulWidget {
  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  TextEditingController provinsi = TextEditingController();
  TextEditingController kabupaten = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController berat = TextEditingController();
  TextEditingController detail_alamat = TextEditingController();
  TextEditingController atas_nama = TextEditingController();
  TextEditingController no_rekening = TextEditingController();
  TextEditingController nominal_transfer = TextEditingController();

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

  Future<double> getGrandTotal() async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        // 'http://10.0.2.2:8000/api/carts/${statusLogin.getInt('membersId')}');
        'http://kuropo.my.id/api/carts/${statusLogin.getInt('membersId')}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      final List<CartsModel> snapshot =
          jsonResponse.map((e) => CartsModel.fromJson(e)).toList();

      final List<int> variantList = [];
      for (var i = 0; i < snapshot.length; i++) {
        variantList.add(snapshot[i].harga!.toInt());
      }
      var sum = variantList.reduce((value, current) => value + current);
      return sum.toDouble();
    } else {
      throw Exception('Error!');
    }
  }

  Future<int> getJumlah() async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        // 'http://10.0.2.2:8000/api/carts/${statusLogin.getInt('membersId')}');
        'http://kuropo.my.id/api/carts/${statusLogin.getInt('membersId')}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      final List<CartsModel> snapshot =
          jsonResponse.map((e) => CartsModel.fromJson(e)).toList();

      return snapshot.length;
    } else {
      throw Exception('Error!');
    }
  }

  Future<List<Map<String, dynamic>>> getCartItem() async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();
    Uri url = Uri.parse(
        // 'http://10.0.2.2:8000/api/carts/${statusLogin.getInt('membersId')}');
        'http://kuropo.my.id/api/carts/${statusLogin.getInt('membersId')}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      final List<CartsModel> res =
          jsonResponse.map((e) => CartsModel.fromJson(e)).toList();

      List<Map<String, dynamic>> newData = [];

      for (var i = 0; i < res.length; i++) {
        Map<String, dynamic> obj = {
          'id_produk': res[i].idBarang,
          'jumlah': res[i].jumlah,
          'size': res[i].size,
          'color': res[i].color,
          'total': res[i].total
        };

        newData.add(obj);
      }

      return newData;
    } else {
      throw Exception('Error!');
    }
  }

  Future<void> sendData(String provinsi, kabupaten, kecamatan, kota, berat,
      detailAlamat, atasNama, noRekening, nominalTransfer) async {
    SharedPreferences statusLogin = await SharedPreferences.getInstance();
    // var url = Uri.parse('https://webhook.site/5ed642d7-a1ed-4a66-9313-4157ef2f08a8');
    // var url = Uri.parse('http://10.0.2.2:8000/api/transaction');
    var url = Uri.parse('http://kuropo.my.id/api/transaction');

    final grandTotal = await getGrandTotal();
    final jumlahProduk = await getJumlah();
    final produk = await getCartItem();

    final response = await http.post(
      url,
      body: jsonEncode({
        'id_member': statusLogin.getInt('membersId'),
        'grand_total': grandTotal,
        'jumlah_produk': jumlahProduk,
        'provinsi': provinsi,
        'kabupaten': kabupaten,
        'kecamatan': kecamatan,
        'detail_alamat': detailAlamat,
        'no_rekening': noRekening,
        'atas_nama': atasNama,
        'produk': produk
      }),
    );

    if (jsonDecode(response.body)['status'] == 201) {
      const snackdemo = SnackBar(
        content: Text('Pesanan berhasil dibuat'),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      print('Error bosssss!');
    }

    print(response.body); // Tambahkan ini untuk mencetak respons
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  //menampilkan foto profil
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        //
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: provinsi,
                      decoration: InputDecoration(
                        labelText: 'Provinsi',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: kabupaten,
                      decoration: InputDecoration(
                        labelText: 'Kabupaten',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: kota,
                      decoration: InputDecoration(
                        labelText: 'Kota',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: berat,
                      decoration: InputDecoration(
                        labelText: 'Berat',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: detail_alamat,
                      decoration: InputDecoration(
                        labelText: 'Detail alamat',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: atas_nama,
                      decoration: InputDecoration(
                        labelText: 'Atas nama',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: no_rekening,
                      decoration: InputDecoration(
                        labelText: 'No. rekening',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: nominal_transfer,
                      decoration: InputDecoration(
                        labelText: 'Nominal transfer',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  /*Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  // Implementasi logika tombol simpan
                },
                child: Text('Buat pesanan'),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF7643),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),*/
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                  right: getProportionateScreenWidth(30),
                  left: getProportionateScreenWidth(30),
                  bottom: 30),
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
                          var sum = variantList
                              .reduce((value, current) => value + current);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "Total:\n",
                                  children: [
                                    TextSpan(
                                      text: "Rp.${sum.toString()}",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(190),
                                child: DefaultButton(
                                  text: "Buat pesanan",
                                  press: () {
                                    sendData(
                                        provinsi.text,
                                        kabupaten.text,
                                        kota.text,
                                        berat.text,
                                        berat.text,
                                        detail_alamat.text,
                                        atas_nama.text,
                                        no_rekening.text,
                                        nominal_transfer.text);

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
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
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
            ),
          )
        ],
      ),
    );
  }
}
