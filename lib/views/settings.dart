import 'package:artsvalley/services/auth.dart';

import 'package:artsvalley/views/info/postupload.dart';
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
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountsPage(),
                  ),
                ); */
              },
              leading: Icon(Icons.person),
              title: Text("Account"),
            ),
            ListTile(
              onTap: () {
                Provider.of<AuthMethods>(context, listen: false).signOut();
              },
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
            ListTile(
              onTap: () {
                showTutorial(context);
              },
              leading: Icon(Icons.info),
              title: Text("Tutorial"),
            ),
            ListTile(
              onTap: () {
                checkTheDb("aEn7bpiTNM8GceD50SaQ");
              },
              leading: Icon(Icons.info),
              title: Text("Tutorial"),
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
