import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/views/settings/accountspage.dart';
import 'package:artsvalley/views/loginscreens/Welcome/welcome_screen.dart';
import 'package:artsvalley/views/settings/settings_menu.dart';
import 'package:artsvalley/views/settings/profile_pic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(
            onEditClick: () {
              Provider.of<EditProfile>(context, listen: false)
                  .selectProfileImageType(
                context,
              );
            },
          ),
          SizedBox(height: 20),
          SettingMenu(
            text: "My Account",
            icon: Icons.person_rounded,
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountsPage(),
                ),
              ),
            },
          ),
          SettingMenu(
            text: "Achievements",
            icon: Icons.emoji_events,
            press: () {},
          ),
          SettingMenu(
            text: "Account Settings",
            icon: Icons.settings,
            press: () {},
          ),
          SettingMenu(
            text: "Help Center",
            icon: Icons.help,
            press: () {},
          ),
          SettingMenu(
            text: "Log Out",
            icon: Icons.logout,
            press: () async {
              await Provider.of<AuthMethods>(context, listen: false).signOut();
              if (Provider.of<User>(context, listen: false) == null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => WelcomeScreen(),
                    ),
                    (Route<dynamic> route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Failed to Logout.. try Later"),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
