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
              title: Text("bhb "), 
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
}
