import 'dart:async';
import 'dart:io';
import 'package:artsvalley/posts/selectedimage.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadPost with ChangeNotifier {
  File uploadPostImage;
  final uuid = Uuid();
  File get getUploadPostImage => uploadPostImage;
  String uploadPostImageUrl;
  String get getUploadImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  // selecting Image
  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal = await picker.getImage(source: source);
    uploadPostImageVal == null
        ? print('select Image')
        : uploadPostImage = File(uploadPostImageVal.path);
    print(uploadPostImageVal.path);

    uploadPostImage != null
        ? Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => SelectedImage(),
            ),
          )
        : print('Image Upload Error');

    notifyListeners();
  }

  //for editing image (Crop Functionlity)
  Future<void> cropImage() async {
    File _croppedImage = await ImageCropper.cropImage(
      sourcePath: uploadPostImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      maxWidth: 500,
      maxHeight: 500,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: Colors.white,
        toolbarTitle: "Edit Image",
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    );

    //cropping the image and assigning the postimage to the cropped image
    //and notifying listeners to update the image path
    if (_croppedImage != null) {
      uploadPostImage = _croppedImage;
      notifyListeners();
    }
  }

  //uploading Image to storage
  Future uploadPostToStorage() async {
    print("Line no . 66 upload post function");
    TaskSnapshot tasksnapshot = await FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}')
        .putFile(uploadPostImage);
    final String downloadurl = await tasksnapshot.ref.getDownloadURL();
    uploadPostImageUrl = downloadurl;
    print(uploadPostImageUrl);
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    print("select post called");
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3 / 2.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ProConstants.shadowColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50),
              ),
            ),
            child: Column(
              children: <Widget>[
                HorizontalLine(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_photo_alternate_rounded),
                            iconSize: 35,
                            color: Colors.blueGrey[200],
                            onPressed: () {
                              //Picking the image from gallary passing the context.
                              pickUploadPostImage(context, ImageSource.gallery);
                            },
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
                            color: Colors.blueGrey[200],
                            onPressed: () {
                              pickUploadPostImage(context, ImageSource.camera);
                            },
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
//typedef can't be declared in classes so declared here . For Image Crop function

typedef capturedImageFile = String Function(String);
typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
