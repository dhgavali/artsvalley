import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/profile_page/image_widget.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _name;

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<User>(context, listen: false).uid;
    var user = Provider.of<User>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.yellow,
            title: Text(
              "Sliver AppBar",
              style: GoogleFonts.dancingScript(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(315.0),
              child: Container(
                height: 365,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<EditProfile>(context, listen: false)
                            .selectProfileImageType(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: _profilePhoto(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          (_name != null)
                              ? _name.toString()
                              : "Welcome To profile",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          user.email,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    CountData(
                      postcount: 3,
                    ),
                    customDivider(context, Colors.grey),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("posts")
                    .where("userId", isEqualTo: userId)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return LinearProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return LinearProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("error occured"));
                  } //parat avaj gela

                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot mypost = snapshot.data.docs[index];

                        return ImageWidget(
                          index: index,
                          posturl: mypost['postUrl'],
                          userId: mypost['userId'],
                        );
                      },
                    );
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<UploadPost>(context, listen: false)
              .selectPostImageType(context);
        },
        child: Icon(
          Icons.add_a_photo,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget addPostButton() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(50),
        boxShadow: customShadowButton(),
      ),
      child: IconButton(
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        onPressed: () {
          Provider.of<UploadPost>(context, listen: false)
              .selectPostImageType(context);
        },
      ),
    );
  }

  Widget _profilePhoto() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .where("userid", isEqualTo: Provider.of<User>(context).uid)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          String _profileurl;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("OOPS eerror occuered"),
                );
              }
              snapshot.data.docs.map((value) {
                _profileurl = value.data()['photoUrl'] ?? "";
                _name = value.data()['displayname'];
                print(_name);
              }).toList();
            }

            return CircleAvatar(
              radius: 60,
              backgroundImage: (_profileurl.length > 0)
                  ? NetworkImage(_profileurl)
                  : AssetImage('assets/images/profile.png'),
              backgroundColor: Colors.white38,
            );
          }
          return LinearProgressIndicator();
        });
  }

  Widget buildImages() {
    return SliverToBoxAdapter(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          primary: false,
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) => ImageWidget(index: index),
        ),
      );
  }
}

class CountData extends StatelessWidget {
  final int postcount;
  CountData({this.postcount});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BoxContent(
          textInside: "Total Posts",
          numvalue: postcount,
        ),
        BoxContent(
          textInside: "Total Likes",
          numvalue: 250,
        ),
        BoxContent(
          textInside: "Arts Sold",
          numvalue: 2,
        ),
      ],
    );
  }
}
