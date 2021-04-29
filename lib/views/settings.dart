import 'dart:developer';

import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/views/loginscreens/Welcome/welcome_screen.dart';
import 'package:artsvalley/views/myanimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController nameController = new TextEditingController();

  validateName(String value) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAnimation(),
                  ),
                );
              },
              leading: Icon(Icons.person),
              title: Text("Account"),
            ),
            ListTile(
              onTap: () {
                showSecurity("Plese connect to Internet..", context);
              },
              leading: Icon(Icons.security),
              title: Text("Security"),
            ),
            ListTile(
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
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  showSecurity(String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.signal_wifi_off,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "No Network",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Text(
              content,
              textAlign: TextAlign.center,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "close",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        });
  }
}
