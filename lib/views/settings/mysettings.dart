import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/settings/myaccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySettingsPage extends StatelessWidget {
  final TextEditingController _replyController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String stringValidator(String value) {
    if (value.isEmpty) return "Plese write your reply";
    if (!stringvalueValidator.hasMatch(value)) {
      return 'Please enter valid input';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child:
                    headingtext("Why would you like to delete your account? "),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _replyController,
                  validator: stringValidator,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Reply",
                  ),
                ),
              ),
              Card(
                  color: kteagreen2,
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.red.shade800,
                    ),
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        //detele account method

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
                                    Container(
                                      child: Text(
                                        "Delete Account Permanently",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Container(
                                  child: Text(
                                      "Note: if you delete your account you will not be able to get it back. All your posts and related data will be deleted Permanently"),
                                ),
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
                                    onPressed: () async {
                                      //TODO: delete User Account Method here
                                      //TODO: add method in databse services..
                                      // deleteUserAccount();
                                      var _user = Provider.of<User>(context,
                                          listen: false);
                                      String uid = _user.uid;
                                      String email = _user.email;

                                      String reason =
                                          _replyController.text.trim();
                                      int result =
                                          await Provider.of<DatabaseService>(
                                                  context,
                                                  listen: false)
                                              .deleteUserAccount(
                                                  uid: uid,
                                                  email: email,
                                                  reason: reason);
                                      print("result is $result");
                                    },
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            });
                      } else {
                        print("empty");
                      }
                    },
                    title: Text(
                      "Delete Your Account",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
