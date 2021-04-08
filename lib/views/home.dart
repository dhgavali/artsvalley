import 'package:artsvalley/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/helper/sharedpref.dart';
import 'package:artsvalley/views/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artsvalley/views/postwidget.dart';
import 'package:flutter/cupertino.dart';
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
        actions: [
          Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Profile(),
                    // builder: (context) => Profile(),
                  ),
                );
                //
              },
            ),
          ),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: ProConstants.drawerColor),
        child: Drawer(
          elevation: 0.0,
          child: ListView(
            children: [
              //TODO: here we have to give ontap properties
              // either we can wrap each menu item inside GestureDetector or we can pass a function to the constructor which will navigate to the new page.
              // will fix this later. or try yourself and find best way to do this
              ListTile(
                leading: Icon(
                  Icons.close,
                  size: 32.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 150,
                child: Container(
                  child: Column(
                    children: [],
                  ),
                ),
              ),
              menuItem("Home", Icons.home),
              menuItem("Profile", Icons.person),
              menuItem("Explore", Icons.explore),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                  child: menuItem("settings", Icons.settings)),
              menuItem("About us", Icons.info),
              GestureDetector(
                  onTap: () async {
                    await firebaseAuth.signOut();
                    firebaseAuth.authStateChanges().listen((User user) {
                      if (user == null) {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()));
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator();
              }

              // var post = snapshot.data.docs
              //     .map((postdata) => {postdata.data()})
              //     .toList();

              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot mypost = snapshot.data.docs[index];
                    return PostWidget(
                      username: "Goerge Bush",
                      profileurl: "assets/images/logo.png",
                      posturl: mypost['postUrl'],
                      caption: mypost['caption'].toString(),
                      likescount: mypost['likes'],
                    );
                  });
            }

            return LinearProgressIndicator();
          }),
    );
  }

  Widget menuItem(String value, IconData icons) {
    return ListTile(
      leading: Icon(
        icons,
        color: ProConstants.bgcolor,
      ),
      title: Text(
        value,
        style: TextStyle(
          fontSize: 20,
          color: ProConstants.bgcolor,
        ),
      ),
    );
  }
}

// ListView(
//         //TODO: here we will use a streambuilder with the listview and then we will fetch the values passed below from the database. which will create the post widget.
//         children: [
//           Container(
//             width: double.infinity,
//             height: 50.0,
//             decoration: BoxDecoration(color: Colors.black87),
//             alignment: Alignment.centerLeft,
//             padding: const EdgeInsets.only(left: 24),
//             child: Text(
//               "Hello, User",
//               style: TextStyle(
//                   fontSize: ProConstants.headingsize, color: Colors.yellow),
//             ),
//           ),
//           PostWidget(
//             profileurl: "assets/images/logo.png",
//             username: "Upendra - project Leader",
//             posturl: "assets/images/mug.jpg",
//             likescount: 101,
//             caption:
//                 "The icons above should be wrapped inside GestureDetector \n and then we have to perform operations of sharing or changing likes count",
//           ),
//           PostWidget(
//             profileurl: "assets/images/logo.png",
//             username: "Abhi Tavhare",
//             posturl: "assets/images/locket.jpg",
//             likescount: 1000,
//             caption:
//                 "caption should be represented as multiline text with \n readmore button also we can open a new page with \n this data on click of readmore",
//           ),
//           PostWidget(
//             profileurl: "assets/images/logo.png",
//             username: "Rohan Yadav",
//             posturl: "assets/images/heart.jpg",
//             likescount: 181,
//             caption: "Implement the sharing functionality @Upendra",
//           ),
//         ],
//       ),
