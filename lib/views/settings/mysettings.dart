import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Card(
            color: keggshell,
            child: ListTile(
              leading: Icon(
                Icons.delete,
                color: Colors.red.shade800,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
                            Text("Delete Account Permanently"),
                          ],
                        ),
                        content: Text(
                            "Note: if you delete your account you will not be able to get it back. All your posts and related data will be deleted Permanently"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              //TODO: delete User Account Method here
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    });
              },
              title: Text(
                "Delete Your Account",
                style: TextStyle(fontSize: 20),
              ),
            )),
      ),
    );
  }
}
