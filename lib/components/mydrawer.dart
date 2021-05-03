import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/loginscreens/Welcome/welcome_screen.dart';
import 'package:artsvalley/views/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            leading: Icon(
              Icons.close,
              size: 32.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 150,
            child: Container(
              child: Column(
                children: [],
              ),
            ),
          ),
          menuItem("Home", Icons.home),
          menuItem("Profile", Icons.person),
          menuItem("Explore", Icons.explore),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
              child: menuItem("settings", Icons.settings)),
          menuItem("About us", Icons.info),
          GestureDetector(
              onTap: () async {
                await Provider.of<AuthMethods>(context, listen: false)
                    .signOut();
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
              child: menuItem("Logout", Icons.logout)),
        ],
      ),
    );
  }

  Widget menuItem(String value, IconData icons) {
    return ListTile(
      leading: Icon(
        icons,
        color: ProConstants.bgcolor,
      ),
      title: Text(
        value,
        style: TextStyle(
          fontSize: 20,
          color: ProConstants.bgcolor,
        ),
      ),
    );
  }
}
