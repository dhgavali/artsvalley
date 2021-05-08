import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/views/home.dart';
import 'package:artsvalley/views/info/about_us.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  // SplashScreen.routeName: (context) => SplashScreen(),
  // LoginScreen.routeName: (context) => LoginPage(),
  // ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  // SignUpScreen.routeName: (context) => SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  // HomeScreen.routeName: (context) => HomeScreen(),
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  // CartScreen.routeName: (context) => CartScreen(),
  // ProfileScreen.routeName: (context) => ProfileScreen(),

  HomePage.routeName: (context) => HomePage(),
  // Profile.routeName: (context) => Profile(),
  
  ProfilePageNew.routeName: (context) => ProfilePageNew(),

};
