import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/store/diy/diy.dart';
import 'package:artsvalley/views/store/paintings/arts.dart';
import 'package:artsvalley/views/store/pottery/pottery.dart';
import 'package:artsvalley/views/store/sketches/sketches.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ProductHomePage extends StatefulWidget {
  @override
  _ProductHomePageState createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  Color primaryColor = Color(0xff109618);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {}),
            SizedBox(
              width: 10,
            ),
            IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
                onPressed: () {})
          ],
          title: Text('Arts Store', style: GoogleFonts.poppins()),
          bottom: TabBar(
            labelColor: kerichblack,
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 6.0,
            onTap: (index) {
            },
            tabs: <Widget>[
              Tab(
                child: Container(
                  child: Text(
                    '#Paintings',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    '#Pottery',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    '#DIY',
                    style: GoogleFonts.poppins(
                       textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    '#Sketches',
                    style: GoogleFonts.poppins(
                       textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Arts(),
            Pottery(),
            DIY(),
            Sketches(),
          ],
        ),
      ),
    );
  }
}
