import 'dart:developer';

import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileImage extends StatefulWidget {
  @override
  _UpdateProfileImageState createState() => _UpdateProfileImageState();
}

class _UpdateProfileImageState extends State<UpdateProfileImage> {
  @override
  Widget build(BuildContext context) {
    var userImage =
        Provider.of<DatabaseService>(context, listen: false).userProfileImage;
    var userImageUrl = Provider.of<DatabaseService>(context, listen: false)
        .userProfileImageUrl;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey[850], borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 150),
              child: Divider(
                thickness: 4.0,
                color: Colors.white10,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 350),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Provider.of<DatabaseService>(context, listen: false)
                          .cropImage(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.4,
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(userImage),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                      'Reselect',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<EditProfile>(context, listen: false)
                          .selectProfileImageType(context);
                    },
                  ),
                  MaterialButton(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<DatabaseService>(context, listen: false)
                          .uploadUserProfileImage(context)
                          .whenComplete(() {
                        FirebaseFirestore.instance
                            .collection(ProConstants.usersCollection)
                            .doc(
                              Provider.of<User>(context, listen: false).uid,
                            )
                            .update({'photoUrl': userImageUrl});
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
