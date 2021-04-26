// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class UserProfileData {
  final String username;
  final String email;
  final String userProfile;
  UserProfileData({
    @required this.username,
    @required this.userProfile,
    @required this.email,
  });
  get usern => this.username;
  get userphoto => this.userProfile;
  get useremail => this.email;

  Map<String, dynamic> toMap() {
    return {
      'name': username,
      'photoUrl': userProfile,
      'email': email,
    };
  }

  factory UserProfileData.fromMap(Map<String, dynamic> map) {
    return UserProfileData(
      username: map['username'],
      userProfile: map['photoUrl'],
      email: map['email'],
    );
  }
}
