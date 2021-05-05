import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

// somecolors:
//
// purple : 261447
// light pink : F39C6B
// crimson red : B20D30  - current
// medium pink  :FF3864 - current
// dark purple : 2F0A28
// eggshell  - F8F4E3
// sea green : 09814A
// eton blue: 7FC6A4
// celadon blue : 2978A0
// middle blue green : 84DCCF
// dark purple : 1F1A38
// rich black - olive : 023C40
// mellow apricot - FFC07F
// forest green : 57A773
// color: Color(0xff17183B),
    // color: Color(0xff0A2463),
    // color: Color(0xff1D1128),
    // color: Color(0xff0E1C36),
    // color: Color(0xffDD1C1A),
    // color: Color(0xffFF1654),
    // color: Color(0xff30011E),
    // color: Color(0xff041F1E),
// imperial red : FF0035
class ProConstants {
  //colors
  static final Color primaryColor = Color(0xffB20D30);
  static final Color bgcolor = Color(0Xff212121);
  static final Color shadowColor = Color(0xff303030);
  static final Color drawerColor = Color(0xfff1f1f1);
  static final Color seagreen = Color(0xff09814a);
  static final Color etonblue = Color(0xff7FC6A4);
  static final Color celadonblue = Color(0xff2978A0);
  static final Color mellowapricot = Color(0xffFFC07F);
  static final Color profileTextColor = Colors.black;
  static final Color secondaryBGColor = Colors.teal;
  static final Color appBarTitleColor = Colors.black;
  static final Color lightText = Colors.white;
  static final Color darkText = Colors.black87;

  static final double textsize = 16.0;
  static final double headingsize = 22.0;
  static final double iconSize = 32.0;
  static final double cardRadius = 10.0;
  static final double buttonWidth = 300.0;
  static final double buttonHeight = 60.0;
  static final double buttonfontsize = 20.0;
  static final double titleSize = 20.0;
  //databases
  static final String usersCollection = "users";
  static final String postsCollection = "posts";

  //TestStyling
  static final TextStyle infoText = new TextStyle(
      color: ProConstants.darkText,
      fontSize: 18,
      decoration: TextDecoration.underline,
      decorationThickness: 2.0,
      decorationColor: Colors.black);

  //settings page fontsize
  static final double settingsText = 18.0;
}
