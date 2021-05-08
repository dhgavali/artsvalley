import 'package:artsvalley/providers/usersdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/customBottomNav.dart';
import 'package:artsvalley/services/networkdepend.dart';
import 'package:artsvalley/views/info/about_us.dart';
import 'package:artsvalley/views/searchUser.dart';
import 'package:artsvalley/views/settings/settingsscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/views/postwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home_page";
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
    return NetworkDepend(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text(
              "ArtsValley",
              style: GoogleFonts.dancingScript(
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await showSearch(
                    context: context,
                    delegate: SearchUser(),
                  );
                  //Search();
                },
                icon: Icon(Icons.search),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 16,
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedMenu: MenuState.home,
          ),
          drawer: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: ProConstants.drawerColor),
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
                        profileurl:
                            (mypost['userProfile'].toString().length > 5)
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
          )),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(
              Icons.close,
              size: 32.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          menuItem("Home", Icons.home),
          menuItem("Profile", Icons.person),
          GestureDetector(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       // builder: (context) => //(),
              //     ),
              //   );
              // },
              child: menuItem("Explore", Icons.explore)),
          menuItem("Art Store", Icons.store),
          GestureDetector(
              onTap: () {
                moveToPage(context, SettingsScreen());
              },
              child: menuItem("settings", Icons.settings)),
          GestureDetector(
              onTap: () {
                moveToPage(
                  context,
                  AboutUsPage(),
                );
              },
              child: menuItem("About us", Icons.info)),
        ],
      ),
    );
  }

  Widget menuItem(String value, IconData icons) {
    return ListTile(
      leading: Icon(
        icons,
        color: ProConstants.bgcolor,
        size: 28.0,
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

moveToPage(BuildContext context, Widget pageName) {
  Navigator.push(
    context,
    CupertinoPageRoute(
      builder: (context) => pageName,
    ),
  );
}
