import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/services/databaseService.dart';
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
            height: MediaQuery.of(context).size.height * 2,
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
                  height: 20,
                ),
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.3,
                  backgroundColor: Colors.transparent,
                  backgroundImage: FileImage(userProfileImage),
                ),
                SizedBox(
                  height: 65,
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
                          Provider.of<DatabaseService>(context, listen: false)
                              .uploadUserProfileImage(context)
                              .whenComplete(() {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(
                                  Provider.of<DatabaseService>(context,
                                          listen: false)
                                      .userid,
                                )
                                .update({'profilephoto': userProfileImageUrl});
                            Navigator.pop(context);
                            //TODO make changes according to u for photo url . (on whencomplete this will sort out).
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

  selectProfileImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3 / 2.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.teal[900],
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white10,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_photo_alternate_rounded),
                            iconSize: 35,
                            color: Colors.lightGreen,
                            onPressed: () {
                              Provider.of<EditProfile>(context, listen: false)
                                  .pickProfileImage(
                                      context, ImageSource.gallery);
                            },
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_a_photo),
                            iconSize: 35,
                            color: Colors.lightGreen,
                            onPressed: () {
                              Provider.of<EditProfile>(context, listen: false)
                                  .pickProfileImage(
                                      context, ImageSource.camera);
                            },
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
