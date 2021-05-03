import 'dart:async';
import 'dart:io';
import 'package:artsvalley/shared/BottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: camel_case_types
class Image_upload extends StatefulWidget {
  @override
  Image_uploadState createState() => Image_uploadState();
}

// ignore: camel_case_types
class Image_uploadState extends State<Image_upload> {
  static double _per = 00.0;
  double _progress;

  File _imageFile;
  final picker = ImagePicker(); //for selection of file
  PickedFile pickedFile; //for stoing selected file

  Future<void> pickImage(ImageSource source) async {
    // ignore: non_constant_identifier_names
    pickedFile = await picker.getImage(source: source);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  //for remove image
  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future uploadImage(BuildContext context) async {
    String fileName = (_imageFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child('uploads/$fileName.');
    UploadTask uploadTask = reference.putFile(_imageFile);
    var state = TaskState.success;

    //checking state of file and displaying a snackbar when its completed
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      _progress =
          snapshot.bytesTransferred.toDouble() / snapshot.totalBytes.toDouble();
      _per = _progress;

      print('Snapshot state: ${snapshot.state}'); //Paused, Running , Complete
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      print(uploadTask.snapshot);
    });

    //uploading task snackbar
    uploadTask.then((TaskSnapshot snapshot) {
      print('Upload Completed');
      ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(
          content: Text('Image Uploaded Successfully .'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.orange[300],
        ),
      );

      //after uploading, image will be removed.
      if (snapshot.state == state) {
        _clear();
      }
    }).catchError((e) {
      return e.toString(); //Firebase Exception
    });
  }

  // key declaration for snackbar
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this key is required for snackbar without key snackbar won't work.
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.yellow],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          //back button container
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CustomNavigationBar()));
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Upload Image Container Text
          Container(
            margin: const EdgeInsets.only(top: 110),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Upload Image to Firebase Storage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),

                //this row is for camera and gallery buttons
                //camera button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              pickImage(ImageSource.camera);
                            },
                            icon: Icon(Icons.add_a_photo),
                            iconSize: 30,
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //gallery button
                    SizedBox(width: 15),
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              pickImage(ImageSource.gallery);
                            },
                            icon: Icon(
                              Icons.add_photo_alternate_rounded,
                            ),
                            iconSize: 30,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //this container is for image displaying
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 520,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 25.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(_imageFile)
                              : Text(''),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: _imageFile == null
                      ? Opacity(opacity: 0.0)
                      : TextButton(
                          onPressed: () {
                            _clear();
                          },
                          child: Text(
                            'Clear Selection',
                            style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 4.0),
                  padding: EdgeInsets.all(4.0),
                  child: _imageFile == null
                      ? Opacity(opacity: 0.0)
                      : LinearProgressIndicator(
                          value: _per,
                        ),
                ),
                Text(
                  '${(_per * 100).toStringAsFixed(2)} % ',
                  style: TextStyle(fontSize: 20.0),
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 16.0),
                      margin: const EdgeInsets.only(
                          top: 5, left: 20.0, right: 20.0, bottom: 15.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.yellow, Colors.orange],
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (_imageFile != null) {
                            uploadImage(context);
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(new SnackBar(
                              content: Text('Please Select an Image!!.'),
                              duration: Duration(seconds: 3),
                              backgroundColor: Colors.orange[300],
                            ));
                          }
                        },
                        child: Text(
                          'Upload Image',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  /* Widget progress(){
  return Container(
    width: 300,
    margin: const EdgeInsets.all(10.0),
      child: Center(
        child: new LiquidLinearProgressIndicator(
          value: _per  ,
          valueColor: AlwaysStoppedAnimation(Colors.orangeAccent[100]),
          backgroundColor: Colors.white,
          borderColor: Colors.orange[900],
          borderWidth: 3.0,
          direction: Axis.horizontal,
          center: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${_progress.toString()} % ',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            ),
          ),
        ),
      ),
  );
} */

/* Widget Action(){
  return Padding(
    padding: EdgeInsets.only(right: 20.0),
    child: Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: (){
          setState(() {
            if(_current == _runningstate){
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            );
          }
          else if (_current == _successState){
            return Icon(Icons.check, color: Colors.white,);
          }
          });
          
        }
      ),
    ),
  );  
} */

  //For Profile picture
  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext con) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
