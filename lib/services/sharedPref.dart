import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final String usernameKey = "USERNAMEKEY";
  static final String userProfileKey = "USERPROFILEKEY";
  static final String userEmailKey = "USEREMAILKEY";
  static final String userUidKey = "USERUIDKEY";
  static final String displayNameKey = "DISPLAYNAMEKEY";

  SharedPreferences _pref;
// preferences.edit().remove("text").commit();
//method to delete a certain shared prefs
// value is basically from 0 to 4.. sequencially as declared as parameters


  //methods for setting sharedpreferences. accepts one parameter value to be save
  Future<void> saveUsername(String username) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(usernameKey, username);
  }

  Future<void> saveUserProfile(String profileUrl) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(userProfileKey, profileUrl);
  }

  Future<void> saveUserEmail(String useremail) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(userEmailKey, useremail);
  }

  Future<void> saveUserUid(String userUid) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(userUidKey, userUid);
  }

  Future<void> saveDisplayName(String displayname) async {
    _pref = await SharedPreferences.getInstance();
    _pref.setString(displayNameKey, displayname);
  }

////Methods for gettign data from sharedPreferences
  ///get methods returns a future of value type string.
  Future<String> getUsername() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(usernameKey);
  }

  Future<String> getUserProfile() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(userProfileKey);
  }

  Future<String> getUserUid() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(userUidKey);
  }

  Future<String> getUserEmail() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(userEmailKey);
  }

  Future<String> getDisplayName() async {
    _pref = await SharedPreferences.getInstance();
    return _pref.getString(displayNameKey);
  }
}
