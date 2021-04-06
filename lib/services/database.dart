import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataMethods {
  final CollectionReference dbconn =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference postdb =
      FirebaseFirestore.instance.collection("postdb");

  //method to add user data on sign up
  Future<DocumentReference> addUserRecord(Map data, UserCredential user) async {
    String userid = user.user.uid;
    Future<DocumentReference> dc;
    print(userid);
    try {
    dc =  dbconn.add(data);
    } catch (e) {
      print(e.message());
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
