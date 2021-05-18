import 'package:flutter/material.dart';

class Product {
  final String title, description;
  final int price, id;
  final Color color;
  Image image;
  Product({
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
      title: "Office Code",
      price: 234,
      description: dummyText,
      image: Image.asset("assets/store/images/1.jpg"),
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Vase",
      price: 234,
      description: dummyText,
      image: Image.asset("assets/store/images/1.jpg"),
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "vase",
      price: 234,
      description: dummyText,
      image: Image.asset("assets/store/images/1.jpg"),
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "Vase",
      price: 234,
      description: dummyText,
      image: Image.asset("assets/store/images/1.jpg"),
      color: Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "Vase",
      price: 234,
      description: dummyText,
      image: Image.asset("assets/store/images/1.jpg"),
      color: Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "Vase",
    price: 234,
    description: dummyText,
    image: Image.asset("assets/store/images/1.jpg"),
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
