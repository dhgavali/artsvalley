import 'package:flutter/material.dart';

class Achievements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Achivements"),
      ),
      body: Center(
        child: Text('You have no achievements so far'),
      ),
    );
  }
}
