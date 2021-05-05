import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/accountspage.dart';
import 'package:artsvalley/views/savedarts.dart';
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
            customCard(
              context: context,
              icon: Icons.person,
              title: "Accounts",
              destination: AccountsPage(),
            ),
            customCard(
              context: context,
              icon: Icons.bookmark,
              title: "Achievement",
              destination: SavedArts(),
            ),
            customCard(
              context: context,
              icon: Icons.bookmark,
              title: "Saved Arts",
              destination: SavedArts(),
            ),
            GestureDetector(
              onTap: () {
                Provider.of<AuthMethods>(context, listen: false).signOut();
              },
              child: customCard(
                color: ProConstants.seagreen,
                icon: Icons.logout,
                title: "Lougout",
              ),
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

Widget customCard(
    {BuildContext context,
    Color color = const Color(0xff041F1E),
    String title,
    IconData icon,
    dynamic destination}) {
  return Card(
    color: color,
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destination,
          ),
        );
      },
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 0.5),
      ),
    ),
  );
}
