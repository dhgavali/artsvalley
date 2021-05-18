import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:artsvalley/profile_page/selectedProfile.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
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

  set profileImageUrl(value) => this.userProfileImageUrl;

  Future pickProfileImage(BuildContext context, ImageSource source) async {
    log("Pick Method was called");
    final pickedUserProfileImage = await picker.getImage(
        source: source, maxHeight: 1000, maxWidth: 1000, imageQuality: 100);
    pickedUserProfileImage == null
        ? print('Please select image')
        : userProfileImage = File(pickedUserProfileImage.path);
    // print(userProfileImage.path);

    userProfileImage != null
        ? moveToPage(context, ShowProfilePhoto())
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
    if (_croppedImage != null) {
      userProfileImage = _croppedImage;
      notifyListeners();
    }
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

}
