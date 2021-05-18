import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:artsvalley/profile_page/newDesignProfile/profile.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesignBTMMyHomePage extends StatefulWidget {
  DesignBTMMyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DesignBTMMyHomePage>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 0; //default index of a first screen

  Widget currentScreen = HomePage(); //Screen

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.home,
    Icons.person,
  ];

  var _pages = [HomePage(), ProfilePage()];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_bottomNavIndex],
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 5.0,
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Provider.of<UploadPost>(context, listen: false)
                .selectPostImageType(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? kPrimaryColor : kerichblack;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 30,
                color: color,
              ),
            ],
          );
        },
        backgroundColor: kPrimaryColorDark,
        // backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: kPrimaryColor,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        // leftCornerRadius: 32,
        // rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
