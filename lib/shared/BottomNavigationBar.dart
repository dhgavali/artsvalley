import 'package:artsvalley/views/settings.dart';
import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/views/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  var _pages = [HomePage(), SettingsPage(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        // color: Color(0xfff261447),
        color: Color(0xffB20D30),
        backgroundColor: Colors.transparent,
        // buttonBackgroundColor: Color(0xffF39C6B),
        buttonBackgroundColor: Color(0xffFF3864),
        items: <Widget>[
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.favorite, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationCurve: Curves.bounceInOut,
      ),
    );
  }
}
