import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/profile_page/image_widget.dart';
import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/profile_page/userimagewidget.dart';
import 'package:artsvalley/services/fetchuserdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatelessWidget {
  final String userid;
  UserProfilePage({this.userid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: StreamBuilder<UserProfileData>(
        stream: FetchUserData(userid: userid).userData,
        builder: (context, snapshot) {
          UserProfileData userData = snapshot.data;
          if (snapshot.hasError) {
            return Center(
              child: Text("Oops!! Some Error Occured"),
            );
          }

          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 215.0,
                  backgroundColor: Colors.white,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(215.0),
                    child: Container(
                      height: 245,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: (userData.userProfile !=
                                          null)
                                      ? NetworkImage(userData.userProfile)
                                      : AssetImage('assets/images/profile.png'),
                                  backgroundColor: Colors.white38,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1.0),
                                            child: Text(
                                              "@${userData.username}",
                                              style: GoogleFonts.lora(
                                                textStyle: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: ProConstants
                                                      .profileTextColor,
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
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("posts")
                          .where("userId", isEqualTo: userid)
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
                        } //parat avaj gela

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
                              return UserImageWidget(
                                index: index,
                                posturl: mypost['postUrl'],
                                userId: mypost['userId'],
                                likescount: likes.length.toString(),
                                caption: mypost['caption'],
                              );
                            },
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final String profileurl;
  final String useremail;

  final String id;

  String _name;
  UserProfile({
    this.profileurl,
    this.useremail,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    String _name;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                // child: _profilePhoto(context, id),
                child: CircleAvatar(
                  radius: 60,
                  // backgroundImage: NetworkImage("_profileurl") ??
                  backgroundImage: (profileurl != null)
                      ? NetworkImage(profileurl)
                      : AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.white38,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    (_name != null) ? _name.toString() : "Welcome To Profile",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    useremail,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  customDivider(context, Colors.grey),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
