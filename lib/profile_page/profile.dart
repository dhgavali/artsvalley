import 'dart:developer';
import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/profile_page/image_widget.dart';
import 'package:artsvalley/services/fetchuserdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder<UserProfileData>(
        stream: FetchUserData(userid: user.uid).userData,
        builder: (context, snapshot) {
          UserProfileData userData = snapshot.data;
          if (snapshot.hasError) {
            return Center(
              child: Text("Oops!! Some Error Occured"),
            );
          }

          if (snapshot.hasData) {
            log("Into the streambuilder new profile page");
            return Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<EditProfile>(context, listen: false)
                                  .selectProfileImageType(context,
                                      imageurl: userData.userProfile);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: (userData.userProfile != null)
                                    ? NetworkImage(userData.userProfile)
                                    : AssetImage('assets/images/profile.png'),
                                backgroundColor: Colors.white38,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData.displayName,
                                style: GoogleFonts.pacifico(
                                  textStyle: TextStyle(
                                    fontSize: 24,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 1.0),
                                      child: Text(
                                        "@${userData.username}",
                                        style: GoogleFonts.lora(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                ProConstants.profileTextColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    CountData(),
                    customDivider(
                      context,
                      Colors.black38,
                      thikness: 2.0,
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .where("userId", isEqualTo: user.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.none) {
                          return LinearProgressIndicator();
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return LinearProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Center(child: Text("error occured"));
                        }

                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot mypost =
                                  snapshot.data.docs[index];
                              Map likes = mypost['likes'];
                              return ImageWidget(
                                index: index,
                                posturl: mypost['postUrl'],
                                userId: mypost['userId'],
                                caption: mypost['caption'],
                                likescount: likes.length.toString(),
                              );
                            },
                          );
                        }
                        return LinearProgressIndicator();
                      }),
                ),
              ],
            );
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}

//TODO: Modify this class so it can be reuse.
class CountData extends StatelessWidget {
  const CountData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dataColumn("17K", "Likes"),
          verticalLine(),
          dataColumn("512", "Posts"),
          verticalLine(),
          Container(
            alignment: Alignment.center,
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              gradient: LinearGradient(
                colors: [Color(0xFFFF3CAC), Color(0xFF2B86C5)],
                begin: Alignment.bottomRight,
                end: Alignment.centerLeft,
              ),
              // color: kPrimaryColor,
            ),
            child: GestureDetector(
              onTap: () {
                print("Follwed ....");
              },
              child: Text(
                "Follow",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget verticalLine() => Container(
      color: Colors.black,
      width: 0.2,
      height: 22,
    );

Widget dataColumn(String title, String subtitle) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "$title",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      Text(
        "$subtitle",
      ),
    ],
  );
}
