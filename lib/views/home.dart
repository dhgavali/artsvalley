import 'package:artsvalley/views/postwidget.dart';
import 'package:artsvalley/views/profilepage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
          ),
        ],
      ),
      body: ListView(
        //TODO: here we will use a streambuilder with the listview and then we will fetch the values passed below from the database. which will create the post widget.
        children: [
          PostWidget(
            profileurl: "assets/images/logo.png",
            username: "Upendra - project Leader",
            posturl: "assets/images/mug.jpg",
            likescount: 101,
            caption:
                "this some random photo caption. Not superior captions like upendra taral.",
          ),
          PostWidget(
            profileurl: "assets/images/logo.png",
            username: "Abhi Tavhare",
            posturl: "assets/images/locket.jpg",
            likescount: 1000,
            caption:
                "caption should be represented as multiline text with readmore button",
          ),
          PostWidget(
            profileurl: "assets/images/logo.png",
            username: "Rohan Yadav",
            posturl: "assets/images/heart.jpg",
            likescount: 181,
            caption: "We need to find some caption seriously!",
          ),
        ],
      ),
    );
  }
}
