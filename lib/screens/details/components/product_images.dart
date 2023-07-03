import 'package:flutter/material.dart';
import 'package:shop/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.id,
    required this.image,
  }) : super(key: key);

  final String id;
  final String image;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.id.toString(),
              child: Image.network(
                // 'http://10.0.2.2:8000/api/files/${widget.image}',
                'http://kuropo.my.id/api/files/${widget.image}',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ...List.generate(widget.image.length,
        //         (index) => buildSmallProductPreview(index)),
        //   ],
        // )
      ],
    );
  }

  // GestureDetector buildSmallProductPreview(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         selectedImage = index;
  //       });
  //     },
  //     child: AnimatedContainer(
  //       duration: defaultDuration,
  //       margin: EdgeInsets.only(right: 15),
  //       padding: EdgeInsets.all(8),
  //       height: getProportionateScreenWidth(48),
  //       width: getProportionateScreenWidth(48),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //             color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
  //       ),
  //       child: Image.asset('http://127.0.0.1:8000/api/files/${widget.image}'),
  //     ),
  //   );
  // }
}
