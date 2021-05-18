import 'package:artsvalley/providers/loading_provider.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/settings/myaccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'captionpost.dart';

class SelectedImage extends StatelessWidget {
  final List<String> artList = <String>[
    "Potrait",
    "Pencil Sktech",
    "Painting",
    "Pottery",
    "CraftWork",
    "Illustration",
    "Others",
  ];

  final List<String> selectArts = [];
  @override
  Widget build(BuildContext context) {
    var _loadProvider = Provider.of<LoadingProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ProConstants.lightText,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 7,
                color: Colors.red,
                child: Consumer<LoadingProvider>(
                  builder: (context, value, child) {
                    return value.isIndicatorLoaded
                        ? LinearProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor),
                            backgroundColor: Colors.grey,
                          )
                        : Container(
                            height: 7.0,
                            color: Colors.white,
                          );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .60,
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
                    headingtext("Select the type of Art"),
                    GroupButton(
                      buttons: artList,
                      spacing: 15.0,
                      isRadio: false,
                      selectedColor: kPrimaryColor,
                      selectedButtons: selectArts,
                      onSelected: (index, isSelected) {
                        if (isSelected) {
                          selectArts.add(artList[index]);
                          print(selectArts);
                        } else {
                          selectArts.remove(artList[index]);
                        }
                        print(selectArts);
                      },
                    ),
                  ],
                ),
              ),

              //buttons for uploading image or reselect
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
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
                      onPressed: () async {
                        _loadProvider.loadLinearProgress(true);
                        await Provider.of<UploadPost>(context, listen: false)
                            .uploadPostToStorage()
                            .whenComplete(() {
                          _loadProvider.loadLinearProgress(false);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => CaptionPost(
                                  selectedArts: selectArts,
                                ),
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
        },
        tooltip: "Edit your photo",
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        backgroundColor: kPrimaryColorDark,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
