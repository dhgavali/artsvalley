import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/services/sharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class UserDataProvider with ChangeNotifier {
  String username;
  String userProfile;

  SharedPrefHelper _prefs = new SharedPrefHelper();
  get usern => this.username;
  get userprof => this.userProfile;
  void intializeUserData(String userid) async {
    log("initialzie mehos wa clled");
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .where("userid", isEqualTo: userid)
        .get();

    log(data.size.toString());
    data.docs.map((snapshot) {
      String _username = snapshot.data()['username'];
      String _userProfile = snapshot.data()['photoUrl'];
      if (snapshot.exists) {
        this.userProfile = _userProfile;
        this.username = _username;
        log("printing details in caption page");
        log(this.userProfile);
        log(this.username);
        UserProfileData.fromMap(snapshot.data());
        _prefs.saveUsername(_username);
        _prefs
            .saveUserProfile(_userProfile)
            .then((value) => log("saved succcesffuly on sharedpreferences"));

        notifyListeners();
      }
    }).toList();
  }
}
