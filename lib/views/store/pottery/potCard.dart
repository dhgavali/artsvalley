import 'package:artsvalley/views/store/pottery/potProducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

class PotItemsCard extends StatelessWidget {
  final PotteryProducts product;
  final Function press;

  const PotItemsCard({Key key, this.product, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
               height: size.height * 0.2,
               width: size.width * 0.4,
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.id}",
               child: Container(
                  child: Image(
                    image: AssetImage(product.image),
                    ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              // products is out demo list
              product.title,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: kTextLightColor
                ),
              ),
            ),
          ),
          Text(
            "\$${product.price}",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}