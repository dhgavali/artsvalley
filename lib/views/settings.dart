import 'dart:developer';

import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/views/loginscreens/Welcome/welcome_screen.dart';
import 'package:artsvalley/views/myanimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart'; 
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart'; 

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
              title: Text("Account"),
            ),
            ListTile(
              title: Text("b "), 
            ),
            ListTile(
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
