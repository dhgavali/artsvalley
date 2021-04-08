import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataMethods {
  final CollectionReference dbconn =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference postdb =
      FirebaseFirestore.instance.collection("postdb");

  //method to add user data on sign up
//  Future<DocumentReference> addUserRecord(
      // {String username,
      // String email,
      // String uid,
      // String photoUrl,
      // String displayname}) async {
  
  Future<DocumentReference> addUserRecord(
      Map userdata) async {
    print("add recrod method startd");
    // String userid = user.user.uid;
    // print(userid);
    Future<DocumentReference> dc;
    try {
      print("try block started");
      //  dbconn.add(data);
      dc = dbconn.add(userdata);
      // print("document refrence : $dc");
    } catch (e) {
      print("catch block activated");
      print(e.toString());
    }
    return dc;
  }

//method to get user data array
  getUserData(String email) {
    dbconn.where('useremail', isEqualTo: email).get().then((userdata) {
      return userdata;
    });
  }
//method to update data in database
// updateUserRecord(){}

//add User Post method

  addPost(String photoUrl, String displayName, String postUrl, String caption) {
    //in this method we have to add this data to the user post databse
    // also we have to increment the post count of the user;
    // so if user have uploaded 20 images. we have to make this 21 in the uploading
  }
}
