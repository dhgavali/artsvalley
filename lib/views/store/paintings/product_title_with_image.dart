import 'package:artsvalley/views/store/paintings/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../diy/diy.detailsScreen.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ) ,          
            ),
            SizedBox(height: kDefaultPaddin),
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Price\n" , style: GoogleFonts.poppins()),
                      TextSpan(
                        text: "\$${product.price}",
                        style: GoogleFonts.poppins()
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 100),
                Expanded(
                  child: Hero(
                    tag: "${product.id}",
                    child: Container(
                      child: Image(
                        image: AssetImage(product.image),
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
