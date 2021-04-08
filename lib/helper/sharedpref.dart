import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static final userEmailKey = "USEREMAIL";
  static final userNameKey = "USERNAME";
  static final displayNameKey = "DISPLAYNAME";
  static final userPhotoUrlKey = "PHOTOURL";
  static final isUserLoginKey = "USERLOGIN";
  static final userIdKey = "USERID";

  //clearing sharedpreferences

  //setting the user values into the shared preferences
  Future<void> isUserLoggedIn(String userstatus) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(isUserLoginKey, userstatus);
  }

  Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userEmailKey, email);
  }

  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, name);
  }

  Future<void> saveDisplayName(String displayname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(displayNameKey, displayname);
  }

  Future<void> saveUserPhotoUrl(String userPhotoUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userPhotoUrlKey, userPhotoUrl);
  }

  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, userId);
  }

//methods to get the user data from the shared prefs

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String> getDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String> getUserProfileUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhotoUrlKey);
  }

  Future<String> getUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(isUserLoginKey);
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }
}
