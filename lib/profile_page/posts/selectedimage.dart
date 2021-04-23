import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'captionpost.dart'; 

class SelectedImage extends StatefulWidget {
  @override
  _SelectedImageState createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  margin: EdgeInsets.only(left: 350, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Provider.of<UploadPost>(context,listen: false).cropImage(); 
                          //cropImage(context);
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
                            left: 20.0, right: 20.0, top: 20.0), 
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
                        Provider.of<UploadPost>(context,listen: false).selectPostImageType(context); 
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
                        /* uploadPostToStorage().whenComplete(() { 
                          editPostSheet(context);
                          print('Image Uploaded');
                        }); */
                        Provider.of<UploadPost>(context,listen: false).uploadPostToStorage().whenComplete(() {
                          Navigator.push(context, CupertinoPageRoute( 
                            builder: (context) => CaptionPost(),
                          ));
                          print("Image Uploaded"); 
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}