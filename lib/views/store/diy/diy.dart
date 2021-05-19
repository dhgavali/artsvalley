import 'package:artsvalley/views/store/diy/diy.detailsScreen.dart';
import 'package:artsvalley/views/store/diy/diyCard.dart';
import 'package:artsvalley/views/store/diy/diyProducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DIY extends StatefulWidget {
  final DIYProduct product;

  const DIY({Key key, this.product}) : super(key: key);
  @override
  _DIYState createState() => _DIYState();
}

class _DIYState extends State<DIY> {
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
              'Explore DIY',
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
              itemBuilder: (context, index) => DIYItemCard(
                product: products[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DIYDetailsScreen(
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