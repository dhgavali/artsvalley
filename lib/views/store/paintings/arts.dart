import 'package:artsvalley/views/store/paintings/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../paintings/detailsScreen.dart';
import '../paintings/item_card.dart';

class Arts extends StatefulWidget {
  final Product product;

  const Arts({Key key, this.product}) : super(key: key);

  @override
  _ArtsState createState() => _ArtsState();
}

class _ArtsState extends State<Arts> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Explore Paintings',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                product: products[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: products[index],
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
