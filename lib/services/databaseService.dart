import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:artsvalley/profile_page/selectedProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

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
  CollectionReference _users = FirebaseFirestore.instance.collection("users");
  CollectionReference _reports =
      FirebaseFirestore.instance.collection("reports");
  CollectionReference _merchants =
      FirebaseFirestore.instance.collection("merchants");
  CollectionReference _artists =
      FirebaseFirestore.instance.collection("artistswork");

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
              builder: (context) => ShowProfilePhoto(),
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
  Future<String> uploadUserProfileImage(File imageFile) async {
    log("into the uploaidng");
    log("file $imageFile.path.toString()");
    TaskSnapshot tasksnapshot = await FirebaseStorage.instance
        .ref()
        .child('UserProfileImage/${imageFile.path}/${TimeOfDay.now()}')
        .putFile(imageFile);

    log("tasksnapshot");
    // log(tasksnapshot.toString());

    final String downloadurl = await tasksnapshot.ref.getDownloadURL();
    // EditProfile().profileImageUrl = downloadurl;
    notifyListeners();
    log(downloadurl);
    return downloadurl;
    // log(EditProfile().getUserProfileImageUrl);
    // Reference imgReference = FirebaseStorage.instance.ref().child(
    //     'UserProfileImage/${EditProfile().userProfileImage.path}/${TimeOfDay.now()}');

    // imageUploadTask = imgReference.putFile(EditProfile().getUserProfileImage);
    // await imageUploadTask.whenComplete(() {
    //   print("Image Uploaded");
    // });
    // imgReference.getDownloadURL().then((url) {
    //   EditProfile().userProfileImageUrl = url.toString();
    //   path = url;
    //   log("uploaded");
    //   notifyListeners();
    // });
    // log("path is $path");
    // return path = downloadurl;
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
//
//
// Create a reference to the document the transaction will use
  updateLikesDB(String documentId, String userid, bool actionType) {
    DocumentReference documentReference = _posts.doc(documentId);

    FirebaseFirestore.instance
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
            case true: //like increment
              newFollowerCount = snapshot.data()['likes'] + 1;
              break;
            case false: //like decrement
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

  //Method to udpate the user data from the settigns
  Future<void> updateUserData(
      {String uid, String mobileNumber, String address, String gender}) async {
    await _users.doc(uid).update({
      'mobileNumber': mobileNumber ?? '',
      'address': address ?? '',
      'gender': gender ?? '',
    });
  }

  //method to update user email
  Future<void> updateUserEmail({String uid, String email}) async {
    await _users.doc(uid).update({
      'useremail': email,
    });
  }

  //method to update user mobile number
  Future<void> updateUserMobileNumber({String uid, String mobileNumber}) async {
    await _users.doc(uid).update({
      'mobileNumber': mobileNumber,
    });
  }

  //method to update user address
  Future<void> updateUserAddress({String uid, String address}) async {
    await _users.doc(uid).update({
      'address': address,
    });
  }

//method to update the gender
  Future<void> updateUserGender({String uid, String gender}) async {
    await _users.doc(uid).update({
      'gender': gender,
    });
  }

//method to add reports to the database
  Future<void> addReportToDb(
      {String postId,
      String uid,
      String comment,
      String reportType1,
      String reportType2}) async {
    String newuid = Uuid().v1();
    String docId = newuid + uid;

    await _reports.doc(docId).set({
      'uid': uid,
      'postId': postId,
      'reportType1': reportType1 ?? FieldValue.delete(),
      'reportType2': reportType2 ?? FieldValue.delete(),
      'comment': comment,
    }, SetOptions(merge: true));
  }

  Future<void> addMerchantDetails(Map merchantData) async {
    await _merchants.doc(merchantData['userid']).set(
          merchantData,
          SetOptions(merge: true),
        );
  }

  Future<bool> fetchMerchantDetails(String uid) async {
    QuerySnapshot _data =
        await _merchants.where("userid", isEqualTo: uid).get();
    int result = _data.docs.length;
    if (result > 0) {
      return true;
    } else {
      return false;
    }
  }

//TODO
  Future<void> addArtDetails(Map artists) async {
    await _artists.doc(artists['userid']).set(
          artists,
          SetOptions(merge: true),
        );
  }
}
