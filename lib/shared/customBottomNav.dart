import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({
    @required this.selectedMenu,
  });

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Colors.yellow;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xff041F1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: MenuState.home == selectedMenu
                ? inActiveIconColor
                : Colors.white,
            onPressed: () => Navigator.pushNamed(context, HomePage.routeName),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<UploadPost>(context, listen: false)
                  .selectPostImageType(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xfff1f1f1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.add_rounded,
                color: kPrimaryColor,
                size: 28,
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.person_rounded),
              color: MenuState.profile == selectedMenu
                  ? inActiveIconColor
                  : Colors.white,
              onPressed: () {
                //Navigator.pushNamed(context, Profile.routeName),
                Navigator.pushNamed(context, ProfilePageNew.routeName);
              }
              //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePageNew()))
              ),
        ],
      ),
    );
  }
}
