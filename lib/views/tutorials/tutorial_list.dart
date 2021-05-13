//TODO: here we will display listview of tutorials
//Tutorials are like how to draw simple sketches
//for kids and beginner artits.


import 'package:flutter/material.dart';
class TutorialsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Tutorial List"),
      ),
      body: ListView.builder(
        //snasphot.data.length
        itemCount: 3,

        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("Elephant"),
              subtitle: Text("Learn how to draw elephant in 6 Steps"),
            ),
          );
        },
      ),
    );
  }
}
