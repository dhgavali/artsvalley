//TODO: here we will display listview of tutorials
//Tutorials are like how to draw simple sketches
//for kids and beginner artits.

import 'package:artsvalley/views/tutorials/how_to_tut/butterfly.dart';
import 'package:artsvalley/views/tutorials/how_to_tut/car.dart';
import 'package:artsvalley/views/tutorials/how_to_tut/elephant_tut.dart';
import 'package:artsvalley/views/tutorials/how_to_tut/home_tut.dart';
import 'package:artsvalley/views/tutorials/how_to_tut/mickeymouse.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TutorialsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text("Tutorial List"),
        ),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  'Elephant',
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  "Learn how to draw elephant in 10 Steps",
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ElephantTutorial()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Butterfly',
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  "Learn how to draw butterfly in 10 Steps",
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ButterflyTutorial()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Car',
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  "Learn how to draw car in 10 Steps",
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarTutorial()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Home',
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  "Learn how to draw home in 9 Steps",
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeTutorial()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Mickey Mouse',
                  style: GoogleFonts.poppins(),
                ),
                subtitle: Text(
                  "Learn how to draw mickey mouse in 9 Steps",
                  style: GoogleFonts.poppins(),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MickeyMouseTutorial()));
                },
              ),
            ),
          ],
        ));
  }
}
