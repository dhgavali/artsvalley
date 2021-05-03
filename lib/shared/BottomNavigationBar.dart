import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/views/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageCurvedBottomNav(),
    );
  }
}

class HomePageCurvedBottomNav extends StatefulWidget {
  HomePageCurvedBottomNav({Key key}) : super(key: key);
  @override
  _HomePageCurvedBottomNavState createState() =>
      _HomePageCurvedBottomNavState();
}

class _HomePageCurvedBottomNavState extends State<HomePageCurvedBottomNav> {
  int selectedPage = 0;
  var _pages = [HomePage(), null, Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Color(0xffB20D30),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0xffFF3864),
        items: <Widget>[
          Icon(Icons.home, color: Colors.white),
          InkWell(
            onTap: () {
              Provider.of<UploadPost>(context, listen: false)
                  .selectPostImageType(context);
            },
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          ),

          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
            case 2:
              setState(() {
                selectedPage = index;
              });
              break;
          }
        },
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationCurve: Curves.bounceInOut,
      ),
    );
  }
}
