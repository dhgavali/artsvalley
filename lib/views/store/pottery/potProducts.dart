import 'package:flutter/material.dart';

class PotteryProducts {
  final String title, description;
  final int price, id;
  final Color color;
  String image;
  PotteryProducts({
    this.id,
    this.image,
    this.title,
    this.price,
    this.description,
    this.color,
  });
}
List<PotteryProducts> products = [
  PotteryProducts(
      id: 1,
      title: "Vase",
      price: 160,
      description: dummyText,
      image: "assets/store/pots/1.jpg",
      color: Color(0xFF3D82AE)),
  PotteryProducts(
      id: 2,
      title: "Indian Pottery",
      price: 120,
      description: dummyText,
      image: "assets/store/pots/2.jpg",
      color: Color(0xFFD3A984)),
  PotteryProducts(
      id: 3,
      title: "Cups",
      price: 145,
      description: dummyText,
      image: "assets/store/pots/3.jpg",
      color: Color(0xFF989493)),
  PotteryProducts(
      id: 4,
      title: " ceramic vases",
      price: 250,
      description: dummyText,
      image: "assets/store/pots/4.jpg",
      color: Color(0xFFE6B398)),
  PotteryProducts(
      id: 5,
      title: "flower pot",
      price: 100,
      description: dummyText,
      image: "assets/store/pots/5.jpg",
      color: Color(0xFFFB7883)),
  PotteryProducts(
    id: 6,
    title: "Pots",
    price: 200,
    description: dummyText,
    image: "assets/store/pots/6.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
"Presented BY ArtsValley Artists";