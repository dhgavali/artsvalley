import 'package:artsvalley/services/sharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
SharedPrefHelper _prefs = new SharedPrefHelper();
class UserDataProvider with ChangeNotifier {
  String username;
  String userProfile;
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
      String _username =  snapshot.data()['username'];
      String _userProfile = snapshot.data()['photoUrl'];
      if (snapshot.exists) {
        this.userProfile = _userProfile;
        this.username = _username;
        log("printing details in caption page");
        // log(this.userProfile);
        // log(this.username);
        // log(_username);
        // log(_userProfile);
        // log("setting user daata");
        // log("setting user daata");
       
        // bool res1, res2;
      _prefs.saveUsername(_username);
        _prefs
            .saveUserProfile(_userProfile)
            .then((value) => log("saved succcesffuly on sharedpreferences"));

        notifyListeners();
      }
    }).toList();
  }
}
