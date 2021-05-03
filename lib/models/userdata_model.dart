// import 'package:flutter/material.dart';

import 'dart:developer';

import 'package:artsvalley/services/sharedPref.dart';
import 'package:flutter/material.dart';

class UserProfileData {
  final String username;
  final String email;
  final String userProfile;
  final String displayName;
  final String useruid;

  UserProfileData(
      {this.username,
      this.email,
      this.userProfile,
      this.displayName,
      this.useruid});
}
