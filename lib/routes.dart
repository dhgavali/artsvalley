import 'package:artsvalley/profile_page/newDesignProfile/profile.dart';
import 'package:artsvalley/views/home.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {

  HomePage.routeName: (context) => HomePage(),
  // Profile.routeName: (context) => Profile(),
  
  ProfilePage.routeName: (context) => ProfilePage(),

};
