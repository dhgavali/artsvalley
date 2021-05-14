import 'package:flutter/material.dart';

class PotraitHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get your potrait"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: Colors.red,
              // child: Image(
              //   // image: ,
              // ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Upload Photo"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//
// Text("A good handmade sketch, not only looks elegant but also makes for an amazing gift on any occasion! A portrait of your friend made into a sketch or a birthday gift for you dad! It just suits everyone and is the right pick to show how much you love them."),
//A good handmade sketch, not only looks elegant but also makes for an amazing gift on any occasion! A portrait of your friend made into a sketch or a birthday gift for you dad! It just suits everyone and is the right pick to show how much you love them.
// // A good handmade sketch, not only looks elegant but also makes for an amazing gift on any occasion! A portrait of your friend made into a sketch or a birthday gift for you dad! It just suits everyone and is the right pick to show how much you love them.
