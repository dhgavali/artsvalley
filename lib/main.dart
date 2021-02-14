import 'package:artsvalley/views/profilepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          backgroundColor: Color(0xfff5f5f5)),
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
