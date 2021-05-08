import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/profile_page/userimagewidget.dart';
import 'package:artsvalley/services/fetchuserdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NewUserProfilePage extends StatefulWidget {
  final String userid;
  NewUserProfilePage({this.userid});

  @override
  _NewUserProfilePageState createState() => _NewUserProfilePageState();
}

class _NewUserProfilePageState extends State<NewUserProfilePage> {
  bool isFollowed = false;
  int followerCount = 0;

  doFollow(Map followerList) {
    String _currentUser = Provider.of<User>(context, listen: false).uid;
    bool _isFollowed = followerList[_currentUser] == true;
    if (_isFollowed) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userid)
          .update({'followerList.$_currentUser': FieldValue.delete()});
      setState(() {
        followerCount -= 1;
        isFollowed = false;
        // widget.followerList[_currentUser] = false;
      });
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userid)
          .update({'followerList.$_currentUser': true});
      setState(() {
        followerCount += 1;
        isFollowed = true;
        // widget.followerList[_currentUser] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<UserProfileData>(
        stream: FetchUserData(userid: widget.userid).userData,
        builder: (context, snapshot) {
          UserProfileData userData = snapshot.data;
          if (snapshot.hasError) {
            return Center(
              child: Text("Oops!! Some Error Occured"),
            );
          }

          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundImage: (userData.userProfile != null)
                              ? NetworkImage(userData.userProfile)
                              : AssetImage('assets/images/profile.png'),
                          backgroundColor: Colors.white38,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        userData.displayName,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${userData.username}",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        alignment: Alignment.center,
                        //padding: EdgeInsets.only(left: 30, right: 30),
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            dataColumn('5', 'Arts'),
                            SizedBox(
                              width: 50,
                              height: 40,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                            ),
                            dataColumn('100', 'Friends'),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 0.5,
                              ),
                            ),
                            dataColumn(
                                '${userData.followerList.length}', 'Followers'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
<<<<<<< HEAD
                            GestureDetector(
                              onTap: () {
                                doFollow(userData.followerList);
                              },
                              child: (userData.followerList[Provider.of<User>(
                                              context,
                                              listen: false)
                                          .uid] ==
                                      null)
                                  ? followButton()
                                  : unFollowButton(),
=======
                            Container(
                              alignment: Alignment.center,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Colors.teal[900],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  print("Follwed ....");
<<<<<<< HEAD
=======
                                  
>>>>>>> 8dfaa1dbaed6daf27aeceb58065e77111a90e6b3

                                },
                                child: Text("Follow",
                                    style: GoogleFonts.gotu(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )),
                              ),
>>>>>>> 752bb33f9596cf6a2a663bd983c5e96cb5ab7fb1
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Colors.teal[900],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  print('contacting..');
                                },
                                child: Text("Contact",
                                    style: GoogleFonts.gotu(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              'Posts',
                              style: GoogleFonts.poppins(
                                textStyle:
                                    TextStyle(fontSize: 22, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          height: 5,
                          width: MediaQuery.of(context).size.width,
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("posts")
                                    .where("userId", isEqualTo: widget.userid)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                          profileurl: mypost['userProfile'],
                                          userdisplayname: mypost['username'],
                                        );
                                      },
                                    );
                                  }
                                  return CircularProgressIndicator();
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  followButton() {
    return Container(
      alignment: Alignment.center,
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: kPrimaryColor,
      ),
      child: Text(
        "Follow",
        style: GoogleFonts.gotu(
          textStyle: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }

  unFollowButton() {
    return Container(
      alignment: Alignment.center,
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: kPrimaryColorDark,
      ),
      child: Text(
        "Unfollow",
        style: GoogleFonts.gotu(
          textStyle: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final String profileurl;
  final String useremail;

  final String id;
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

Widget dataColumn(String title, String subtitle) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "$title",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Text(
        "$subtitle",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    ],
  );
}
