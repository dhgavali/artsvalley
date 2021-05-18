import 'dart:developer';

import 'package:artsvalley/models/product.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/store/already_registered.dart';
import 'package:artsvalley/views/store/detailsScreen.dart';
import 'package:artsvalley/views/store/item_card.dart';
import 'package:artsvalley/views/store/pages/diy.dart';
import 'package:artsvalley/views/store/pages/pottery.dart';
import 'package:artsvalley/views/store/pages/sketches.dart';
import 'package:artsvalley/views/store/shopform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key key, this.product}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<String> categories = ["#Paintings", "#Pottery", "#DIY", "Sketches"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arts Store"),
        elevation: 0,
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
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 5),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Explore Artsvalley's Arts ",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontSize: 22,
              )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            
                            /* switch (index) {
                              case 1:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Pottery()));
                                break;
                              case 2:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DIY()));
                                break;
                              case 3:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sketches()));
                                break;
                              default:
                            } */
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPaddin),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                categories[index],
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: selectedIndex == index
                                        ? kTextColor
                                        : kTextLightColor,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: kDefaultPaddin / 4), //top padding 5
                                height: 2,
                                width: 30,
                                color: selectedIndex == index
                                    ? Colors.black
                                    : Colors.transparent,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
          //images cards
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: PageView(
                  children: <Widget>[
                    GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
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
              //TODO
              //another gridview for pottery here 
                  ],
                )

                /* GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
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
                
              ), */

                ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          bool _isFilledAlready =
              await Provider.of<DatabaseService>(context, listen: false)
                  .fetchMerchantDetails(
                      Provider.of<User>(context, listen: false).uid);
          _isFilledAlready
              ? moveToPage(context, ArleadyRegistered())
              : moveToPage(context, ShopForm());
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            "Become Merchant",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
