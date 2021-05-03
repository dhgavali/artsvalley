import 'dart:async';
import 'package:artsvalley/models/userdata_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchUserData {
  //userid property
  //
  final String userid;
  FetchUserData({this.userid});

  //COllection reference

  final CollectionReference _users =
      FirebaseFirestore.instance.collection("users");

  //userdata from snapshot
  UserProfileData _userDataFromSnapshots(DocumentSnapshot snapshot) {
    return UserProfileData(
      useruid: snapshot.data()['userid'],
      username: snapshot.data()['username'],
      email: snapshot.data()['useremail'],
      userProfile: snapshot.data()['photoUrl'],
      displayName: snapshot.data()['displayname'],
    );
  }

//method for fetchiing the data user data
//

  Stream<UserProfileData> get userData {
    return _users
        .doc(userid)
        .snapshots()
        .map(_userDataFromSnapshots);
  }
}
