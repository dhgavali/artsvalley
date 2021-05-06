import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  //new theme
   primaryColor: ProConstants.primaryColor,
            primarySwatch: Colors.teal,
            // visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Color(0xfff1f1f1),
            accentColor: Colors.white,
            // textTheme: TextTheme(
            //   headline1: TextStyle(
            //     fontSize: 28.00,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   headline2: TextStyle(
            //     fontSize: 26.00,
            //     fontWeight: FontWeight.bold,
            //   ),
            //   bodyText1: TextStyle(
            //     fontSize: 20.00,
            //   ),
            // ),
  
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
        headline1: TextStyle(
                fontSize: 28.00,
                fontWeight: FontWeight.bold,
              ),
              headline2: TextStyle(
                fontSize: 26.00,
                fontWeight: FontWeight.bold,
              ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}
