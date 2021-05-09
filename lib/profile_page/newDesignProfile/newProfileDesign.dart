import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/profile_page/image_widget.dart';
import 'package:artsvalley/services/fetchuserdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/customBottomNav.dart';
import 'package:artsvalley/views/settings/settingsscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageNew extends StatelessWidget {
  static final String routeName = "/new_profile_page";
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);

    ValueNotifier<int> totalarts = ValueNotifier(0);
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
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
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.profile,
        ),
        body: StreamBuilder<UserProfileData>(
            stream: FetchUserData(userid: user.uid).userData,
            builder: (context, snapshot) {
              UserProfileData userData = snapshot.data;
              if (snapshot.hasError) {
                return Center(
                  child: Text('Opps!! Something Went Wrong'),
                );
              }

              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: GestureDetector(
                              onTap: () {
                               //TODO : here we can display profile full size if we want to.
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundImage: (userData.userProfile !=
                                          null)
                                      ? NetworkImage(userData.userProfile)
                                      : AssetImage('assets/images/profile.png'),
                                  backgroundColor: Colors.white38,
                                ),
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
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "@ ${userData.username}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          )
                        ],
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
                            ValueListenableBuilder<int>(
                              valueListenable: totalarts,
                              builder: (context, value, child) {
                                return dataColumn('$value', 'Arts');
                              },
                            ),
                            // dataColumn('$totalarts', 'Arts'),
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
<<<<<<< HEAD
                            dataColumn('100', 'Following'),
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
                                },
                                child: Text("Follow",
                                    style: GoogleFonts.gotu(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                print('contacting..');
                                await _sendMail(
                                    userData.email, userData.displayName);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Colors.red[800],
                                ),
                                child: Text("Contact",
                                    style: GoogleFonts.gotu(
                                      textStyle: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )),
                              ),
                            ),
=======
                            dataColumn(
                                "${userData.followerList.length}", 'Followers'),
>>>>>>> c2a61630c78a17a5c19ca134d71ae3e1b0609836
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
                                    .where("userId", isEqualTo: user.uid)
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(child: Text("error occured"));
                                  }

                                  if (snapshot.hasData) {
                                    // totalarts = snapshot.data.docs.length;
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
                                          postId: mypost['postId'],
                                          profileurl: mypost['userProfile'],
                                          userdisplayname: mypost['username'],
                                          likescount: likes.length.toString(),
                                        );
                                      },
                                    );
                                  }
                                  return LinearProgressIndicator();
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return LinearProgressIndicator();
            }));
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
<<<<<<< HEAD

_sendMail(String email, String username) async {
  // Android and iOS
  String uri = 'mailto:$email?subject=Greetings&body=Hello $username';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
=======
>>>>>>> c2a61630c78a17a5c19ca134d71ae3e1b0609836
