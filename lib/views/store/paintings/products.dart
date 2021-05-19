import 'package:flutter/material.dart';

class Product {
  final String title, description;
  final int price, id;
  final Color color;
  RichText text;
  String image;
  Product({
    this.text,
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.color,
  });
}

List<Product> products = [
  Product(
      id: 1,
      title: "Valley",
      price: 300,
      description: "SKU : PRT_232 \n  Availability : Delivered within 2-5 days when ordered as Unframed, and 5-7 days when ordered as Framed. \n Quality :  Ultra High Definition Prints with Outstanding Details \n  Size :  21in x 32in \n Medium :  High Quality, Non-Fading, UV Resistant Printer Inks \n Surface :  Canvas \n Return Policy :  15 Days if ordered as Unframed. Not applicable if ordered as Framed or in Custom Size, or if delivery is outside India. \n Customizable? :  Yes, this art can be customized to any Size.",
      image: "assets/store/paints/1.jpg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Lion",
      price: 100,
      description: "SKU : PRT_232 \n  Availability : Delivered within 2-5 days when ordered as Unframed, and 5-7 days when ordered as Framed. \n Quality :  Ultra High Definition Prints with Outstanding Details \n  Size :  21in x 32in \n Medium :  High Quality, Non-Fading, UV Resistant Printer Inks \n Surface :  Canvas \n Return Policy :  15 Days if ordered as Unframed. Not applicable if ordered as Framed or in Custom Size, or if delivery is outside India. \n Customizable? :  Yes, this art can be customized to any Size.",
      image: "assets/store/paints/l.jpg",
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "SunRise",
      price: 250,
      description: "SKU : PRT_232 \n  Availability : Delivered within 2-5 days when ordered as Unframed, and 5-7 days when ordered as Framed. \n Quality :  Ultra High Definition Prints with Outstanding Details \n  Size :  21in x 32in \n Medium :  High Quality, Non-Fading, UV Resistant Printer Inks \n Surface :  Canvas \n Return Policy :  15 Days if ordered as Unframed. Not applicable if ordered as Framed or in Custom Size, or if delivery is outside India. \n Customizable? :  Yes, this art can be customized to any Size.",
      image: "assets/store/paints/3.jpg",
      color: Color(0xFFE6B398)),
  Product(
      id: 4,
      title: "Olha Darchuk Art",
      price: 234,
      description: "SKU : PRT_232 \n  Availability : Delivered within 2-5 days when ordered as Unframed, and 5-7 days when ordered as Framed. \n Quality :  Ultra High Definition Prints with Outstanding Details \n  Size :  21in x 32in \n Medium :  High Quality, Non-Fading, UV Resistant Printer Inks \n Surface :  Canvas \n Return Policy :  15 Days if ordered as Unframed. Not applicable if ordered as Framed or in Custom Size, or if delivery is outside India. \n Customizable? :  Yes, this art can be customized to any Size.",
      image: "assets/store/paints/7.jpg",
      color: Colors.lightGreen[300]),
  Product(
      id: 5,
      title: "White Horse",
      price: 234,
      description: "SKU : PRT_232 \n  Availability : Delivered within 2-5 days when ordered as Unframed, and 5-7 days when ordered as Framed. \n Quality :  Ultra High Definition Prints with Outstanding Details \n  Size :  21in x 32in \n Medium :  High Quality, Non-Fading, UV Resistant Printer Inks \n Surface :  Canvas \n Return Policy :  15 Days if ordered as Unframed. Not applicable if ordered as Framed or in Custom Size, or if delivery is outside India. \n Customizable? :  Yes, this art can be customized to any Size.",
      image: "assets/store/paints/2.jpg",
      color: Colors.brown[400]),
  Product(
    id: 6,
    title: "Park West Collection",
    price: 150,
      description: "SKU : PRT_232 \n  Availability : Delivered within 2-5 days when ordered as Unframed, and 5-7 days when ordered as Framed. \n Quality :  Ultra High Definition Prints with Outstanding Details \n  Size :  21in x 32in \n Medium :  High Quality, Non-Fading, UV Resistant Printer Inks \n Surface :  Canvas \n Return Policy :  15 Days if ordered as Unframed. Not applicable if ordered as Framed or in Custom Size, or if delivery is outside India. \n Customizable? :  Yes, this art can be customized to any Size.",
    image: "assets/store/paints/4.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
