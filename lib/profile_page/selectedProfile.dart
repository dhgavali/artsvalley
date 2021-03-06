//this class will dispaly a profile photo selected

import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/profile_page/newDesignProfile/profile.dart';
import 'package:artsvalley/providers/loading_provider.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/btm_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowProfilePhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _loadProvider = Provider.of<LoadingProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Profile Photo"),
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 7.0,
              color: Colors.red,
              child: Consumer<LoadingProvider>(
                builder: (context, value, child) {
                  return value.isIndicatorLoaded
                      ? LinearProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          backgroundColor: Colors.grey,
                        )
                      : Container(
                          height: 7.0,
                          color: Colors.white,
                        );
                },
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
                      Provider.of<EditProfile>(context, listen: false)
                          .cropImage(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<EditProfile>(
              builder: (context, value, child) {
                return CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.3,
                  backgroundColor: Colors.transparent,
                  backgroundImage: FileImage(value.userProfileImage),
                );
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    child: Text(
                      'Reselect',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      Provider.of<EditProfile>(context, listen: false)
                          .selectProfileImageType(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      'Upload Image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      // log("onpressed of upload image");
                      _loadProvider.loadLinearProgress(true);
                      String _value = await Provider.of<DatabaseService>(
                              context,
                              listen: false)
                          .uploadUserProfileImage(
                              Provider.of<EditProfile>(context, listen: false)
                                  .getUserProfileImage);

                      String _uid =
                          Provider.of<User>(context, listen: false).uid;
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(
                            _uid,
                          )
                          .update({'photoUrl': _value});

                      await FirebaseFirestore.instance
                          .collection("posts")
                          .where("userId", isEqualTo: _uid)
                          .get()
                          .then((QuerySnapshot snapshot) {
                        snapshot.docs.forEach((element) {
                          element.reference.update({'userProfile': _value});
                        });
                        print(_value);
                        print("Done replaceing");
                      });
                      _loadProvider.loadLinearProgress(false);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DesignBTMMyHomePage()),
                          (route) => false);
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
