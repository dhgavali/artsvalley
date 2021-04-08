import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';

class DatabaseService with ChangeNotifier {
  final String uid;
  DatabaseService({this.uid});

  String userEmail, userName, userImage, fullName;
  String get getUserName => userName;
  String get getUserEmail => userEmail;
  String get getUserImage => userImage;
  String get getName => fullName;
  TextEditingController fullNameInputController = new TextEditingController();

  final userid = FirebaseAuth.instance.currentUser.uid;

  UploadTask imageUploadTask;

  //collection refernce
  final CollectionReference userDataref =
      FirebaseFirestore.instance.collection('users');

  //Actully this function that i created we are using it for creating record collection to cloud firebase and  updation of data
  //ignore this

  Future updateUserData(String username, String name, String email,
      String profilePhotoUrl) async {
    return await userDataref.doc(uid).set({
      'Fullname': fullNameInputController.text,
      'email': email,
      'username': username,
      'profilephoto': profilePhotoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      //'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  //initial data for stream

//for profile picture
  //user Profile image upload task
  Future uploadUserProfileImage(BuildContext context) async {
    Reference imgReference = FirebaseStorage.instance.ref().child(
        'UserProfileImage/${Provider.of<EditProfile>(context, listen: false).userProfileImage.path}/${TimeOfDay.now()}');

    imageUploadTask = imgReference.putFile(
        Provider.of<EditProfile>(context, listen: false).getUserProfileImage);
    await imageUploadTask.whenComplete(() {
      print("Image Uploaded");
    });
    imgReference.getDownloadURL().then((url) {
      Provider.of<EditProfile>(context, listen: false).userProfileImageUrl =
          url.toString();
      print(
          "User Profile image url = ${Provider.of<EditProfile>(context, listen: false).getUserProfileImageUrl}");
      notifyListeners();
    });
  }

//creating post collection into firestore
  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  //creating collection
  Future createUserCollection(BuildContext context, dynamic data) async {
    return userDataref.doc(userid).set(data);
  }

  //for accessing data fro, firestore
 

  notifyListeners();
}
