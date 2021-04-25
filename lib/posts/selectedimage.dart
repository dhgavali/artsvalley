import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'captionpost.dart';

class SelectedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ProConstants.lightText,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .60,
                      // width: MediaQuery.of(context).size.width ,
                      
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      child: ClipRRect(
                        child: Consumer<UploadPost>(
                          builder: (context, value, child) {
                            return Image.file(
                              value.uploadPostImage,
                              //for animation
                              frameBuilder: (BuildContext context, Widget child,
                                      int frame, bool wasSynchronouslyLoaded) =>
                                  wasSynchronouslyLoaded
                                      ? child
                                      : AnimatedOpacity(
                                          child: child,
                                          opacity: frame == null ? 0 : 1,
                                          duration: const Duration(seconds: 2),
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

              //buttons for uploading image or reselect
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      child: Text(
                        'Reselect',
                        style: ProConstants.infoText,
                      ),
                      onPressed: () {
                        Provider.of<UploadPost>(context, listen: false)
                            .selectPostImageType(context);
                      },
                    ),
                    MaterialButton(
                      child: Text(
                        'Upload Image',
                        style: ProConstants.infoText,
                      ),
                      onPressed: () {
                        Provider.of<UploadPost>(context, listen: false)
                            .uploadPostToStorage()
                            .whenComplete(() {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CaptionPost(),
                              ));
                          print("Image Uploaded");
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<UploadPost>(context, listen: false).cropImage();
          // cropImage(context);
        },
        tooltip: "Edit your photo",
        child: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

//TODO : Code to retrieve lost data
//
//Future<void> retrieveLostData() async {
//   final LostData response =
//       await picker.getLostData();
//   if (response.isEmpty) {
//     return;
//   }
//   if (response.file != null) {
//     setState(() {
//       if (response.type == RetrieveType.video) {
//         _handleVideo(response.file);
//       } else {
//         _handleImage(response.file);
//       }
//     });
//   } else {
//     _handleError(response.exception);
//   }
// }
