import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(),
      ),
      body: Body(
        id: agrs.id.toString(),
        image: agrs.image.toString(),
        title: agrs.title.toString(),
        deskripsi: agrs.deskripsi.toString(),
        harga: agrs.harga,
      ),
    );
  }
}

class ProductDetailsArguments {
  final String id;
  final String image;
  final String title;
  final String deskripsi;
  final int harga;

  ProductDetailsArguments({
    required this.id,
    required this.image,
    required this.title,
    required this.deskripsi,
    required this.harga,
  });
}
