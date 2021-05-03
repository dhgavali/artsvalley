import 'package:artsvalley/components/mydrawer.dart';
import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/providers/usersdata.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/loginscreens/Welcome/welcome_screen.dart';
import 'package:artsvalley/views/searchUser.dart';
import 'package:artsvalley/views/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/views/postwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'searchUser.dart';
import 'dart:developer';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var likeRef;

  @override
  void initState() {
    UserDataProvider().intializeUserData(FirebaseAuth.instance.currentUser.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "ArtsValley",
          style: GoogleFonts.dancingScript(
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () async {
                final searchdata = await showSearch(
                  context: context,
                  delegate: SearchUser(),
                );
              },
              icon: Icon(Icons.search),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
          ),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: ProConstants.drawerColor),
        child: MyDrawer(),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          print("Stream builder started");
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snapshot.data.docs[index];
                  Map likescount = mypost['likes'];
                  String currentUser =
                      Provider.of<User>(context, listen: false).uid;
                  bool isLiked = likescount[currentUser] == true;
                  return PostWidget(
                    username: mypost['username'],
                    profileurl: (mypost['userProfile'].toString().length > 5)
                        ? mypost['userProfile']
                        : "assets/images/profile.png",
                    posturl: mypost['postUrl'],
                    caption: mypost['caption'],
                    likescount: likescount.length,
                    postId: mypost['postId'],
                    userId: mypost['userId'],
                    likes: mypost['likes'],
                    isLiked: isLiked,
                  );
                });
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}
