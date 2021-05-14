import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
import 'package:artsvalley/providers/usersdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/customBottomNav.dart';
import 'package:artsvalley/services/networkdepend.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/info/about_us.dart';
import 'package:artsvalley/views/searchUser.dart';
import 'package:artsvalley/views/settings/settingsscreen.dart';
import 'package:artsvalley/views/store/notifyingpage.dart';
import 'package:artsvalley/views/store/product_page.dart';
import 'package:artsvalley/views/tutorials/tutorial_home.dart';
import 'package:artsvalley/views/tutorials/tutorial_list.dart';
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
            // title: Text(
            //   "ArtsValley",
            //   style: GoogleFonts.dancingScript(
            //       textStyle:
            //           TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            // ),
            title: ColorizeAnimatedTextKit(
              speed: Duration(milliseconds: 1000),
              totalRepeatCount: 1,
              repeatForever: false,
              text: ["ArtsValley"],
              textStyle: GoogleFonts.dancingScript(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              colors: [
                Color(0xff85FFBD),
                Color(0xFF3DDC97),
                Color(0xFFF39C6B),
                Color(0xFFFF495C),
                Color(0xFFE8D33F),
                Color(0xFFFFEA61),
                Color(0xFFFFB7C3),
                Color(0xFF2BFF88),
              ],
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
            data: Theme.of(context).copyWith(canvasColor: kerichblack),
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
              color: kteagreen,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          menuItem("Home", Icons.home),
          GestureDetector(
              onTap: () {
                moveToPage(
                  context,
                  ProfilePageNew(),
                );
              },
              child: menuItem("Profile", Icons.person)),
          GestureDetector(
            onTap: () {
              moveToPage(context, NoftifyUser());
            },
            child: menuItem("Explore", Icons.explore),
          ),
          GestureDetector(
            onTap: () {
              moveToPage(
                context,
                ProductPage(),
              );
            },
            child: menuItem("Art Store", Icons.store),
          ),
          GestureDetector(
            onTap: () {
              moveToPage(context, TutorialHomePage());
            },
            child: menuItem(
              "Tutorials",
              Icons.menu_book_outlined,
            ),
          ),
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
    return Card(
      color: kerichblack,
      child: ListTile(
        leading: Icon(
          icons,
          color: kteagreen,
          size: 28.0,
        ),
        contentPadding: const EdgeInsets.only(left: 20.0),
        title: Text(
          value,
          style: TextStyle(
            fontSize: 20,
            // color: Colors.white,
            color: keggshell,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
