import 'package:flutter/material.dart';

class SketchesProducts{
  final String title, description;
  final int price, id;
  final Color color;
  String image;

  SketchesProducts({
    this.title, 
    this.description, 
    this.price, 
    this.id, 
    this.color,
    this.image
  });
}


List<SketchesProducts> products = [
  SketchesProducts(
      id: 1,
      title: "Office Code",
      price: 234,
      description: dummyText,
      image: "assets/store/sketches/1.jpg",
      color: Color(0xFF3D82AE)),
  SketchesProducts(
      id: 2,
      title: "Tommy Shelbi",
      price: 220,
      description: dummyText,
      image: "assets/store/sketches/tommy.jpg",
      color: Color(0xFFD3A984)),
  SketchesProducts(
      id: 3,
      title: "Narutoo",
      price: 200,
      description: dummyText,
      image: "assets/store/sketches/3.jpg",
      color: Color(0xFF989493)),
  SketchesProducts(
      id: 4,
      title: "Narutoo",
      price: 150,
      description: dummyText,
      image: "assets/store/sketches/4.jpg",
      color: Color(0xFFE6B398)),
  SketchesProducts(
      id: 5,
      title: "Jack Sparrow",
      price: 250,
      description: dummyText,
      image: "assets/store/sketches/5.jpg",
      color: Color(0xFFFB7883)),
  SketchesProducts(
    id: 6,
    title: "Horse",
    price: 200,
    description: dummyText,
    image: "assets/store/sketches/h2.jpg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
"Presented by Artsvalley";