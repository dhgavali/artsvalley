import 'package:artsvalley/views/store/pottery/potCard.dart';
import 'package:artsvalley/views/store/pottery/potDetailsScreen.dart';
import 'package:artsvalley/views/store/pottery/potProducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Pottery extends StatefulWidget {
  final PotteryProducts products;

  const Pottery({Key key, this.products}) : super(key: key);
  @override
  _PotteryState createState() => _PotteryState();
}

class _PotteryState extends State<Pottery> {

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
              'Explore Potteries',
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
              itemBuilder: (context, index) => PotItemsCard(
                product: products[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PotDetailsScreen(
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