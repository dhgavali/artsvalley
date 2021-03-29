import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/helper/sharedpref.dart';
import 'package:artsvalley/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artsvalley/views/postwidget.dart';
import 'package:artsvalley/views/profilepage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {},
        // ),
        actions: [
          Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () async {
                SharedPrefsHelper _sharedPref = new SharedPrefsHelper();
                String _username = await _sharedPref.getUsername();
                String _userPhotoUrl = await _sharedPref.getUserProfileUrl();
                String _userDisplayName = await _sharedPref.getDisplayName();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                              userName: _username,
                              profileUrl: _userPhotoUrl,
                              displayName: _userDisplayName,
                            )));
              },
            ),
          ),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xff212121)),
        child: Drawer(
          elevation: 0.0,
          child: ListView(
            children: [
              //TODO: here we have to give ontap properties
              // either we can wrap each menu item inside GestureDetector or we can pass a function to the constructor which will navigate to the new page.
              // will fix this later. or try yourself and find best way to do this
              menuItem("Home", Icons.home),
              menuItem("Profile", Icons.person),
              menuItem("Explore", Icons.explore),
              menuItem("settings", Icons.settings),
              menuItem("About us", Icons.info),
              GestureDetector(
                  onTap: () async {
                    await firebaseAuth.signOut();
                    firebaseAuth.authStateChanges().listen((User user) {
                      if (user == null) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      } else {
                        return Center(
                          child: Text("Failed to loguot"),
                        );
                      }
                    });
                  },
                  child: menuItem("Logout", Icons.logout)),
            ],
          ),
        ),
      ),
      body: ListView(
        //TODO: here we will use a streambuilder with the listview and then we will fetch the values passed below from the database. which will create the post widget.
        children: [
          Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(color: Colors.black87),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              "Hello, User",
              style: TextStyle(
                  fontSize: ProConstants.headingsize, color: Colors.yellow),
            ),
          ),
           PostWidget(
            profileurl: "assets/images/logo.png",
            username: "Upendra - project Leader",
            posturl: "assets/images/mug.jpg",
            likescount: 101,
            caption:
                "The icons above should be wrapped inside GestureDetector \n and then we have to perform operations of sharing or changing likes count",
          ),
          PostWidget(
            profileurl: "assets/images/logo.png",
            username: "Abhi Tavhare",
            posturl: "assets/images/locket.jpg",
            likescount: 1000,
            caption:
                "caption should be represented as multiline text with \n readmore button also we can open a new page with \n this data on click of readmore",
          ),
          PostWidget(
            profileurl: "assets/images/logo.png",
            username: "Rohan Yadav",
            posturl: "assets/images/heart.jpg",
            likescount: 181,
            caption: "Implement the sharing functionality @Upendra",
          ),
        ],
      ),
    );
  }

  Widget menuItem(String value, IconData icons) {
    return ListTile(
      leading: Icon(
        icons,
        color: Colors.redAccent,
      ),
      title: Text(
        value,
        style: TextStyle(
          fontSize: 20,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
