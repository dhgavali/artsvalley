//TODO: here we will display listview of tutorials
//Tutorials are like how to draw simple sketches
//for kids and beginner artits.

import 'package:flutter/material.dart';

class TutorialsListPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        //snasphot.data.length
        itemCount: 0,

        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
