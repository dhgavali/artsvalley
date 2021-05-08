import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:artsvalley/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile with ChangeNotifier {
  final picker = ImagePicker();
  File userProfileImage;
  File get getUserProfileImage => userProfileImage;
  String userProfileImageUrl;
  String get getUserProfileImageUrl => userProfileImageUrl;

  Future pickProfileImage(BuildContext context, ImageSource source) async {
    print("Pick Method was called");
    final pickedUserProfileImage = await picker.getImage(source: source);
    pickedUserProfileImage == null
        ? print('Please select image')
        : userProfileImage = File(pickedUserProfileImage.path);
    print(userProfileImage.path);

    userProfileImage != null
        ? showProfile(context)
        : print('Image Upload Eroor');
    notifyListeners();
  }

  Future<void> cropImage(BuildContext context) async {
    var img =
        Provider.of<EditProfile>(context, listen: false).userProfileImage.path;

    File _croppedImage = await ImageCropper.cropImage(
      sourcePath: img,
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
    this.userProfileImage = _croppedImage;
    notifyListeners();
  }

  showProfile(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 2.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white10,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 350),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          cropImage(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.3,
                  backgroundColor: Colors.transparent,
                  backgroundImage: FileImage(userProfileImage),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          'Reselect',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          selectProfileImageType(context);
                        },
                      ),
                      MaterialButton(
                        child: Text(
                          'Upload Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          log("onpressed of upload image");
                          Provider.of<DatabaseService>(context, listen: false)
                              .uploadUserProfileImage(context)
                              .whenComplete(() {
                            log("upload completed");
                            log("${Provider.of<EditProfile>(context)
                                  .getUserProfileImageUrl}");
                            FirebaseFirestore.instance
                                .collection(ProConstants.usersCollection)
                                .doc(
                                  Provider.of<User>(context, listen: false).uid,
                                )
                                .update({
                              'photoUrl': Provider.of<EditProfile>(context)
                                  .getUserProfileImageUrl
                            });
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  selectProfileImageType(BuildContext context, {String imageurl}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
            child: ListView(
              children: [
                ListTile(
                  title: Text(
                    "Update Profile Photo",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Provider.of<EditProfile>(context, listen: false)
                        .pickProfileImage(context, ImageSource.gallery);
                  },
                  leading: Icon(Icons.photo),
                  title: Text("Upload Image From gallary"),
                ),
                ListTile(
                  onTap: () {
                    Provider.of<EditProfile>(context, listen: false)
                        .pickProfileImage(context, ImageSource.camera);
                  },
                  leading: Icon(Icons.add_a_photo),
                  title: Text("Upload Image From Camera"),
                ),
              ],
            ),
          );
        });
  }

  // showImage(BuildContext context, String imageUrl) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           width: 200,
  //           height: 200,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //           ),
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //           child: FadeInImage(
  //             width: 250,
  //             height: 250,
  //             image: NetworkImage(imageUrl) ?? CircularProgressIndicator(),
  //             placeholder: AssetImage("assets/images/spinner.gif"),
  //           ),
  //         );
  //       });
  // }
}
