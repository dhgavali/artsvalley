import 'package:flutter/material.dart';

class DIYProduct {
  final String title, description;
  final int price, id;
  final Color color;
  String image;

  DIYProduct({
    this.title, 
    this.description, 
    this.price, 
    this.id, 
    this.color,
    this.image
  });
}


List<DIYProduct> products = [
  DIYProduct(
      id: 1,
      title: "DIY Wall Decoration",
      price: 100,
      description: dummyText,
      image: "assets/store/diy/1.jpg",
      color: Color(0xFF3D82AE)),
  DIYProduct(
      id: 2,
      title: "DIY Box Frame",
      price: 120,
      description: dummyText,
      image: "assets/store/diy/2.jpg",
      color: Color(0xFFD3A984)),
  DIYProduct(
      id: 3,
      title: "DIT Shelfs",
      price: 150,
      description: dummyText,
      image: "assets/store/diy/3.jpg",
      color: Color(0xFF989493)),
  DIYProduct(
      id: 4,
      title: "DIY Acrylic Bottle",
      price: 130,
      description: dummyText,
      image: "assets/store/diy/4.jpg",
      color: Color(0xFFE6B398)),
  DIYProduct(
      id: 5,
      title: "DIY Acrylic Bottle",
      price: 250,
      description: dummyText,
      image: "assets/store/diy/5.jpg",
      color: Color(0xFFFB7883)),
  DIYProduct(
    id: 6,
    title: "DIY Acrylic Bottle",
    price: 200,
    description: dummyText,
    image: "assets/store/diy/6.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
"Presented By ArtsValley";
