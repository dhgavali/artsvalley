import 'package:artsvalley/views/store/paintings/products.dart';
import 'package:artsvalley/views/store/paintings/product_title_with_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const kDefaultPaddin = 20.0;

class DetailsScreen extends StatelessWidget {
  final Product product;
  DetailsScreen({Key key, this.product}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // each product have a color
      backgroundColor: product.color,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  //bottom box decoration with description
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3 ),
                    padding: EdgeInsets.only(
                        top: size.height * 0.07,
                        left: kDefaultPaddin,
                        right: kDefaultPaddin,
                        ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        //description block
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: kDefaultPaddin),
                          child: Text(
                            product.description,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),

                          ),


                        SizedBox(height: kDefaultPaddin,),
                        //heart icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //add cartcounter
                            CartCounter(),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(8),
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF6464),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.favorite, ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPaddin / 2,
                        ),
                        //shopping cart and buy now button
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPaddin),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: kDefaultPaddin),
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: product.color,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.shopping_cart_rounded),
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      backgroundColor: product.color,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Buy  Now".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                            ],
                          ),
                          
                        ),
                      ],
                    ),
                    //no need for colors dot
                  ),
                  //after clicking on product it will navigate to description page with image 
                  Container(
                    //margin: EdgeInsets.only(left: 20,right: 20),
                    child: ProductTitleWithImage(product: product)),
                ],
              ),
              
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}

//counter for cart

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}