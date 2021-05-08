import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Text(
              "this is help page. Here we will display one contact option that can be a either a contact button or directly our email. user can reach to us for any query, also We will display some  FAQ here. \n 1. What is the app about \n 2. What are the benefits of using this app \n 3. How to delete account \n 4. How to forgot password \n 5. How to change Email"),
        ),
      ),
    );
  }
}
