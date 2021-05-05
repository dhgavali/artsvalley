import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/views/accountspage.dart';

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
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountsPage(),
                  ),
                );
              },
              leading: Icon(Icons.person),
              title: Text("Account"),
            ),
            Card(
              color: Colors.red,
              child: ListTile(
                onTap: () {
                  showTutorial(context);
                },
                leading: Icon(Icons.bookmark),
                title: Text("Saved Arts"),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  showTutorial(context);
                },
                leading: Icon(Icons.bookmark),
                title: Text("Saved Arts"),
              ),
            ),
            ListTile(
              onTap: () {
                Provider.of<AuthMethods>(context, listen: false).signOut();
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

Widget customCard({BuildContext context, Color color, String title, IconData icon, Function onTapHandler}) {
  return Card(
    color: color,
    child: ListTile(
      onTap: () {
        onTapHandler(context);
      },
      leading: Icon(icon),
      title: Text(title),
    ),
  );
}

onTapHandler(){
  
}