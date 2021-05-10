import 'package:artsvalley/helper/sizeconfig.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
// const kSecondaryColor = Color(0xff041F1E);
const kPrimaryColorDark = Color(0xff041F1E);
const kPrimaryLightColor = Color(0xFFFFECDF);
const ketonBlue = Color(0xFF7FC6A4);
const klightPink = Color(0xFFF39C6B);
const keggshell = Color(0xFFF8F4E3);
const kceladonBlue = Color(0xFF2978A0);
const kmellowApricot = Color(0xFFFFC07F);
const kforestGreen = Color(0xFF57A773);
const kLightOrange = Color(0xFFFF7643);
const kseagreen = Color(0xff09814a);
// const kPrimaryColor = Color(0xFFFF7643);

//ENUM
//ENUM
//ENUM

enum MenuState { home, favourite, message, profile }

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

//Extra constants data for new UI

// const kPrimaryColor = Color(0xFFFF7643);
// const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp contactNumberValidator = RegExp(r"^[0-9]{10}");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

// final otpInputDecoration = InputDecoration(
//   contentPadding:
//       EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//   border: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   enabledBorder: outlineInputBorder(),
// );

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
