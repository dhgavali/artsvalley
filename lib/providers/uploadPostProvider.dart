import 'dart:async';
import 'dart:io';
import 'package:artsvalley/posts/selectedimage.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    TaskSnapshot tasksnapshot = await FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage.path}/${TimeOfDay.now()}')
        .putFile(uploadPostImage);
    final String downloadurl = await tasksnapshot.ref.getDownloadURL();
    uploadPostImageUrl = downloadurl;
    notifyListeners();
  }

  // final _storageBucket = FirebaseStorage.instanceFor(
  //     bucket: 'gs://art-valley.appspot.com',
  //   );

  Future deleteImageFromDb() async{
    /* final Reference ref = FirebaseStorage.instance.refFromURL(uploadPostImageUrl);
    try {
      log(ref.toString());
      await ref.delete();
      log("check is it deleted or not !!!!!!!!!");
      return true;
    } catch (e) {
      return e.toString();
    } */

    if(uploadPostImage != null) {
     //Reference reference =  FirebaseStorage.instance.ref(uploadPostImage.path);
      String filePath = uploadPostImageUrl.replaceAll(new RegExp(r'https://firebasestorage.googleapis.com/v0/b/art-valley.appspot.com/o/posts%2Fdata%2Fuser%2F0%2Fcom.dhenterprises.artsvalley%2Fcache%2F'), '');
      filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');

      filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');

      Reference reference = FirebaseStorage.instance.ref();
      reference.child(filePath).delete().then((_) => print('Successfully deleted $filePath storage item' ));

     //FirebaseStorage.instance.ref().child(filepath).delete().then((_) => print("Successfully deleted $filepath storage item"));
      //print(reference);
      //log(uploadPostImageUrl);
      //await reference.delete();

      /* try { 
      await reference.delete();
      print('check wheter it is deleted or not ??!!');
      } catch (e){
        e.toString();
      } */
    }

/*     var photo = _storageBucket.refFromURL(uploadPostImageUrl);
    log(photo.toString());
    print('checkkkkk!!!!!');
    await photo.delete(); */

   /*  try {
    var photo = FirebaseStorage.instance.ref(uploadPostImage.path).delete();
    log(photo.toString());
    } catch (e) {
      debugPrint('error deleting $e');
    }
 */
    
    
  }

//TODO 
  Future deleteFromCloudAndDb(String postid) async{
    try {
      FirebaseFirestore.instance.collection('posts').doc(postid).delete();
      print("post Deleted");
      
    } catch (e) {
      e.toString();
    }
    
  }

   Future deleteAcheivementFromCloudAndDb(String uid) async{
    try {
      FirebaseFirestore.instance.collection('acheivements').doc(uid).delete();
      print("Acheivement Deleted");
      
    } catch (e) {
      e.toString();
    }
    
  }


  selectPostImageType(BuildContext context) {
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
