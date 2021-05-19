import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/tutorials/tutorial_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TutorialHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorials"),
      ),
      body: Stack(
        children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
             /*  ListTile(
                title: Text(
                  '"Every Artist was first an Amature"',
                  style: GoogleFonts.caveat(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    " - Ralph Waldo Emerson",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ), */
              Image.asset('assets/tp/back.jpg'),
            ],
          ),
        ),
      ]),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
          onPressed: () {
            //It will navigate to tutorialsPageList
            moveToPage(context, TutorialsListPage());
          },
          child: Text("learn To Draw"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
