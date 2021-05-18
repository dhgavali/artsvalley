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
import 'package:url_launcher/url_launcher.dart';

class NewUserProfilePage extends StatefulWidget {
  final String userid;
  NewUserProfilePage({this.userid});

  @override
  _NewUserProfilePageState createState() => _NewUserProfilePageState();
}

class _NewUserProfilePageState extends State<NewUserProfilePage> {
  String artcount;
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('acheivements')
                                        .doc(widget.userid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(
                                              'Opps!! Something Went Wrong'),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        DocumentSnapshot level = snapshot.data;
                                        // log(level.data()['level'].toString());
                                        return Column(
                                          children: [
                                            //TODO if possible go to below link download image and make it asset image
                                            Image.network(
                                              'https://purepng.com/public/uploads/large/purepng.com-gold-cup-trophygolden-cupgoldtrophymedal-1421526534849zfzh1.png',
                                              width: 70,
                                              height: 50,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            level.exists
                                                ? Container(
                                                    child: '${level.data()['level']}' !=
                                                            null
                                                        ? Text(
                                                            "Level ${level.data()['level'].toString()} ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          14),
                                                            ))
                                                        : Text('level 0',style: GoogleFonts.poppins(),),
                                                  )
                                                : Text('level 0'),
                                          ],
                                        );
                                      }
                                      return CircularProgressIndicator();
                                    }),
                              ),
                              Container(
                                decoration: kboxDecoration(),
                                padding: const EdgeInsets.all(5.0),
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.white),
                                      shape: BoxShape.circle),
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundImage:
                                        (userData.userProfile != null)
                                            ? NetworkImage(userData.userProfile)
                                            : AssetImage(
                                                'assets/images/profile.png'),
                                    backgroundColor: Colors.white38,
                                  ),
                                ),
                              ),
                              dataColumn('${userData.followerList.length}',
                                  'Followers'),
                            ],
                          ),
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
                        height: 30,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                            ),
                            GestureDetector(
                              onTap: () {
                                _sendMail(userData.email, userData.displayName);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Colors.pink[700],
                                ),
                                child: Text(
                                  "Contact",
                                  style: GoogleFonts.gotu(
                                    textStyle: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
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
                                    //.orderBy('timestamp', descending: true)
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
                                        String currentUser = Provider.of<User>(
                                                context,
                                                listen: false)
                                            .uid;
                                        bool isLiked =
                                            likes[currentUser] == true;
                                        return UserImageWidget(
                                          index: index,
                                          postId: mypost['postId'],
                                          posturl: mypost['postUrl'],
                                          userId: mypost['userId'],
                                          likescount: likes.length.toString(),
                                          caption: mypost['caption'],
                                          profileurl: mypost['userProfile'],
                                          userdisplayname: mypost['username'],
                                          likes: likes,
                                          isLiked: isLiked,
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
        color: Colors.yellow[500],
      ),
      child: Text(
        "Unfollow",
        style: GoogleFonts.gotu(
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

_sendMail(String email, String username) async {
  // Android and iOS
  String uri = 'mailto:$email?subject=Greetings&body=Hello $username';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
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
