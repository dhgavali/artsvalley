import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/providers/usersdata.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadPost with ChangeNotifier {
  TextEditingController captionController = new TextEditingController();

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
        ? showPostImageType(context)
        : print('Image Upload Error');

    notifyListeners();
  }

  //for editing image (Crop Functionlity)
  Future<void> cropImage(BuildContext context) async {
    File _croppedImage = await ImageCropper.cropImage(
      sourcePath: uploadPostImage.path,
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

    //cropping the image and assigning the postimage to the cropped image
    //and notifying listeners to update the image path
    uploadPostImage = _croppedImage;
    notifyListeners();
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

  //for selecting image either from galary or camera
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
                              Navigator.pop(context);
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

  showPostImageType(BuildContext context) {
    print("show post called");
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 60,
                        // width: MediaQuery.of(context).size.width ,
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 25.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Consumer<UploadPost>(
                            builder: (context, value, child) {
                              return Image.file(
                                value.uploadPostImage,
                                //for animation
                                frameBuilder: (BuildContext context,
                                        Widget child,
                                        int frame,
                                        bool wasSynchronouslyLoaded) =>
                                    wasSynchronouslyLoaded
                                        ? child
                                        : AnimatedOpacity(
                                            child: child,
                                            opacity: frame == null ? 0 : 1,
                                            duration:
                                                const Duration(seconds: 2),
                                            curve: Curves.easeOut,
                                          ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //buttons for uploading image or reselect
                Row(
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
                        selectPostImageType(context);
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
                        uploadPostToStorage().whenComplete(() {
                          editPostSheet(context);
                          print('Image Uploaded');
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  //sheet for caption

  editPostSheet(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    var dataProvider = Provider.of<UserDataProvider>(context, listen: false);
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white10,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 520,
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.file(
                            uploadPostImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: Icon(Icons.subtitles),
                      ),
                      Container(
                        height: 110.0,
                        width: 5.0,
                        color: Colors.blueGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 120.0,
                          width: 330.0,
                          child: TextField(
                            maxLines: 5,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(150)
                            ],
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 120,
                            controller: captionController,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Add a caption",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  child: Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  color: Colors.blueGrey,
                  //creating key value pair here
                  //TODO: Post map here
                  onPressed: () {
                    log("upload post time");
                    log("Current user is: ");
                    // print(user.email);

                    String _username = dataProvider.usern;
                    String _userProfile = dataProvider.userprof;
                    // log(_userProfile);
                    String _postid = uuid.v1();
                    Provider.of<DatabaseService>(context, listen: false)
                        .uploadPostData({
                      'caption': captionController.text.trim(),
                      'userId': user.uid,
                      'postUrl': uploadPostImageUrl,
                      'likes': 0,
                      'postId': _postid,
                      'username': _username,
                      'userProfile': user.photoURL,
                    }, _postid).whenComplete(() {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile()),
                          (Route<dynamic> route) => false);
                    });
                  },
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(12),
            ),
          );
        });
  }
}

//typedef can't be declared in classes so declared here . For Image Crop function

typedef capturedImageFile = String Function(String);
typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);
