import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/services/sharedPref.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/loginscreens/Signup/components/or_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  final _prefs = SharedPrefHelper();
  String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [
            infoLabel("Personal Information", 20),
            customDivider(context, Colors.grey),
            infoLabel("Username: ", 18),
            infoLabel("dhgavali ", 22),
            customDivider(context, Colors.grey),
            infoLabel("email: ", 18),
            infoLabel("dhgavali@gmail.com", 22),
            customDivider(context, Colors.grey),
            infoLabel("mobile number: ", 18),
            infoLabel("8989854521", 22),
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10.0),
              color: kPrimaryColor,
              child: infoLabel("Update Mobile Number", 18, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                deleteUserAccount(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10.0),
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    infoLabel("Delete Account", 18, color: Colors.white),
                  ],
                ),
              ),
            ),
            customDivider(context, Colors.grey),
          ],
        ),
      ),
    );
  }

  void deleteUserAccount(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Are you sure want to delete your account? ",
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                children: [
                  infoLabel(
                      "Note: if you delete your account you will not be able to recover it back. It will be permanently deleted. also your posts and other data will be removed permanently",
                      16),
                  InkWell(
                    onTap: () {
                      //TODO: move to the new page
                      //send otp or ask for password verify user.
                      //then delete the record. this is enough
                    },
                    child: RoundedButton(
                      text: "Proceed",
                      hpadding: 10,
                      width: 150,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: RoundedButton(
                      text: "Cancel",
                      color: Colors.grey,
                      hpadding: 10,
                      width: 150,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
