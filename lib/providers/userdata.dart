import 'dart:async';

import 'package:artsvalley/providers/userid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider with ChangeNotifier {
  String username;
  String displayname;
  String profilephoto;
  String email;
  // final String authuserid = FirebaseUser().myUserid;
  // CollectionReference _dbconn = FirebaseFirestore.instance.collection("users");
  //  initialiseData() async {
  //   // QuerySnapshot data =
  //   //     await _dbconn.where("userid", isEqualTo: authuserid).get();
  //   // print(data.docs.length);
  //   QuerySnapshot _userdata =
  //       await _dbconn.where("userid", isEqualTo: FirebaseUser().myUserid).get();
  //    _userdata.docs.map((data) {
  //     return data;
  //   });
  // }

//getting the data
  // get getUsername => this.username;
  // get getProfilePhoto => this.profilephoto;
  // get getDisplayName => this.displayname;
  // get getEmail => this.email;
  // get getUserId => this.authuserid;
}
