import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/profile_page/updateProfilePhoto.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:artsvalley/profile_page/edit_Profile.dart';

class DatabaseService with ChangeNotifier {
  UploadTask imageUploadTask;
  int _likescount;

  int get likescount => this._likescount;

  final picker = ImagePicker();
  File userProfileImage;
  File get getUserProfileImage => userProfileImage;
  String userProfileImageUrl;
  String get getUserProfileImageUrl => userProfileImageUrl;

//database constatns
  CollectionReference _posts = FirebaseFirestore.instance.collection("posts");
CollectionReference _favorites = FirebaseFirestore.instance.collection("favorites");
CollectionReference _users = FirebaseFirestore.instance.collection("users");
  // TODO: here we also need to create a setter for likes count
  // Stream set likescount(value) => this._likescount;
  //initial data for stream

  Future pickProfileImage(BuildContext context, ImageSource source) async {
    final pickedUserProfileImage = await picker.getImage(source: source);
    pickedUserProfileImage == null
        ? print('Please select image')
        : userProfileImage = File(pickedUserProfileImage.path);
    print(userProfileImage.path);

    userProfileImage != null
        ? Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => UpdateProfileImage(),
            ))
        : print('Image Upload Eroor');
    notifyListeners();
  }

  //crop profile image
  Future<void> cropImage(BuildContext context) async {
    File _croppedImage = await ImageCropper.cropImage(
      sourcePath: userProfileImage.path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      compressQuality: 100,
      maxWidth: 500,
      maxHeight: 500,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.white,
          toolbarTitle: "Edit Image",
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    userProfileImage = _croppedImage;
    notifyListeners();
  }

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

  //TOOD: method for uploading the likedby collection in database
  //The flow of liking the post what things will be affected
  //1. Post will liked and true /false will be set to the icon in database
  //2. Count increment and update in the ui
  //3. userid will be added in likedby table
  //also. based on the value of the true or false
  likePost(String postId, String userId) async {
      
    //   DocumentSnapshot _data = await _subColl.doc(postId).get();
    //  bool isLiked =  _data.data()['isliked'];

    // _subColl.doc(postId).collection("likedBy").doc(userId).set(
    //   {
    //     'userId': userId,

    //   },
    //   SetOptions(merge: true),
    // ).whenComplete(() {
    //   log("updated successfully liikes count");
    // });
  }
}

//TODO: method for fetching data from the firebase

//
