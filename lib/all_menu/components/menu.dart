import 'package:flutter/material.dart';
import 'package:shop/components/product_card.dart';
import 'package:shop/models/Product.dart';

import '../../../size_config.dart';

class AllMenu extends StatelessWidget {
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
              spacing: 5,
              runSpacing: 15,
              children: [
                ...List.generate(
                  demoProducts.length,
                  (index) {
                    if (demoProducts[index].isPopular)
                      return ProductCard(product: demoProducts[index]);

                    return SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
              ],
            )
          ],
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
      ],
    );
  }
}
