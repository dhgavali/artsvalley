import 'package:artsvalley/providers/user.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserDataProvider with ChangeNotifier {
  String username;
  String displayname;
  String profilephoto;
  String email;
  String userid;

  initialiseData() async {
    CollectionReference _db =
        FirebaseFirestore.instance.collection(ProConstants.usersCollection);
    QuerySnapshot result =
        await _db.where("userid", isEqualTo: FirebaseUser().uid).get();

  result.docs.map((value)  {
    this.username = value.data()['username'];
    this.displayname = value.data()['displayname'];
    this.email = value.data()['email'];
    this.profilephoto = value.data()['email'];
    this.userid = value.data()['email'];
    });
  }

  get getUsername => this.username;
  get getProfilePhoto => this.profilephoto;
  get getDisplayName => this.displayname;
  get getEmail => this.email;
  get getUserId => this.userid;
}
