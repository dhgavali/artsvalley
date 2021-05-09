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
      image: Image.network('https://images.unsplash.com/photo-1617693322135-13831d116f79?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzZ8fHBvdHRlcnklMjBzdHVkaW98ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "Vase",
      price: 234,
      description: dummyText,
      image: Image.network('https://images.unsplash.com/photo-1581783342308-f792dbdd27c5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dmFzZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "vase",
      price: 234,
      description: dummyText,
      image: Image.network('https://images.unsplash.com/photo-1553511667-567b93c369d4?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dmFzZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "Vase",
      price: 234,
      description: dummyText,
      image: Image.network('https://images.unsplash.com/photo-1586802978403-6406fb3ddfff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHZhc2V8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
      color: Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "Vase",
      price: 234,
      description: dummyText,
      image: Image.network('https://images.unsplash.com/photo-1602059179382-8552d62353cf?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjV8fHZhc2V8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
      color: Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "Vase",
    price: 234,
    description: dummyText,
    image: Image.network('https://images.unsplash.com/photo-1588874133473-d6d9c9dd4f31?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fHZhc2V8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
