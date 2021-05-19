import 'package:artsvalley/views/store/sketches/sketchCard.dart';
import 'package:artsvalley/views/store/sketches/sketchDetailsScreen.dart';
import 'package:artsvalley/views/store/sketches/sketchProducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Sketches extends StatefulWidget {
  final SketchesProducts product;

  const Sketches({Key key, this.product}) : super(key: key);

  @override
  _SketchesState createState() => _SketchesState();
}

class _SketchesState extends State<Sketches> {
  
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
              'Explore Sketches',
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
              itemBuilder: (context, index) => SketchItemCard(
                product: products[index],
                press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SketchDeatailsScreen(
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
