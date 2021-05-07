import 'package:artsvalley/services/sharedPref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/cupertino.dart';

class UserDataProvider with ChangeNotifier {
  String username;
  String userProfile;
  String displayName;
  String name;

  SharedPrefHelper _prefs = new SharedPrefHelper();
  get usern => this.username;
  get userprof => this.userProfile;

  void intializeUserData(String userid) async {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .where("userid", isEqualTo: userid)
        .get();
    data.docs.map((snapshot) async {
      String _username = snapshot.data()['username'];
      String _useremail = snapshot.data()['useremail'];
      String _userProfile = snapshot.data()['photoUrl'] ?? "null";
      String _displayName = snapshot.data()['displayname'];
      String _userId = snapshot.data()['userid'];

      await _prefs.saveUserEmail(_useremail);
      await _prefs.saveUserUid(_userId);
      await _prefs.saveUserProfile(_userProfile);
      await _prefs.saveUsername(_username);
      _prefs.saveDisplayName(_displayName).whenComplete(() {
        // UserProfileData().setData();
      });

      notifyListeners();
    }).toList();
  }
}
