import 'dart:async';
import 'dart:convert';

import 'package:artsvalley/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:artsvalley/profile_page/edit_Profile.dart';

class DatabaseService with ChangeNotifier {
  UploadTask imageUploadTask;
  int _likescount;

  int get likescount => this._likescount;

  // TODO: here we also need to create a setter for likes count
  // Stream set likescount(value) => this._likescount;
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

//TODO: For udpating the likes
//
//
// Create a reference to the document the transaction will use
  updateLikesDB(String documentId, bool actionType) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(ProConstants.postsCollection)
        .doc(documentId);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          // Get the document
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }

          // Update the follower count based on the current count
          // Note: this could be done without a transaction
          // by updating the population using FieldValue.increment()
          int newFollowerCount;

          switch (actionType) {
            case true:
              print("true like increemnted");
              newFollowerCount = snapshot.data()['likes'] + 1;
              break;
            case false:
              print("false like decremented");
              if (snapshot.data()['likes'] <= 0) {
                print("cannot decrement");
                newFollowerCount = 0;
              } else {
                newFollowerCount = snapshot.data()['likes'] - 1;
              }
              break;
          }
          // Perform an update on the document
          transaction.update(documentReference, {'likes': newFollowerCount});

          // Return the new count
          return newFollowerCount;
        })
        .then((value) => print("Follower count updated to $value"))
        .catchError(
            (error) => print("Failed to update user followers: $error"));
  }
}

//TODO: method for fetching data from the firebase

//
