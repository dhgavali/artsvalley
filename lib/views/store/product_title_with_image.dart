import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'product_page.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Aristocratic Hand Bag",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            product.title,
            /* style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold), */
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${product.price}",
                      /* style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold), */
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "${product.id}",
                  child: /* Image.asset(
                    product.image,
                    fit: BoxFit.fill,
                    height: 30,
                    width: 30,
                  ), */
                  Image.network('https://png.pngtree.com/png-clipart/20190903/original/pngtree-flowers-in-a-vase-png-image_4438169.jpg',
                  fit: BoxFit.fill,
                 width: MediaQuery.of(context).size.width *0.2,
                 height: MediaQuery.of(context).size.height *0.2,
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
