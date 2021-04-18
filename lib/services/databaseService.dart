import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';

class DatabaseService with ChangeNotifier {

  UploadTask imageUploadTask;

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
  Future uploadPostData(dynamic data, String docid) async {
    return FirebaseFirestore.instance.collection('posts').doc(docid).set(data);
  }

  //creating collection
  // Future createUserCollection(BuildContext context, dynamic data) async {
  //   return userDataref.doc(userid).set(data);
  // }

  //for accessing data fro, firestore

  notifyListeners();
}
