//TODO: How to upload arts steps:
// 1. Upload1 pic: "Click on Add btn"
// 2. Upload2 pic: "If your want select photo than gallary or else if your want click photo than Camera"
// 3. Upload3 pic: "After select gallery, select any art photo from yoru storage"
// 4. Upload4 pic: "Your select photo will appear on artsvalley, here you can reselect your art photo again or else proceed by clicing on upload image"
// 5. Upload4 pic: "If you want edit your photo you can by clicking on edit button present on top-right corner of the screen"
// 6. Upload5 pic: "Here your can edit ur photo...(give short edit info)"
// 7. Upload6,7,8,9 pic: "After clicking on upload image, you'll jump on caption page, here you can write caption to your image"
// 8. Upload10 pic: "After clicking on upload your photo has been successfully upload on ArtsValley"
// 9.Upload11,12 pic: "Here you can check your arts uploaded...Congrastulations"

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;
  String img;
  String uploadImg1;
  String uploadImg2;
  String uploadImg3;

  ItemModel({
    this.expanded: false,
    this.headerItem,
    this.discription,
    this.colorsItem,
    this.img,
    this.uploadImg1,
    this.uploadImg2,
    this.uploadImg3,
  });
}

class ExpansionPanelDemo extends StatefulWidget {
  @override
  _ExpansionPanelDemoState createState() => _ExpansionPanelDemoState();
}

class _ExpansionPanelDemoState extends State<ExpansionPanelDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            faq1("1. What is arts valley", 0),
            faq2("2. How to upload image on ArtsValley", 1, isImage: true),
            faq3("3. How to change password", 2, isImage: true),
          ],
        ),
      ),
    );
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      discription:
          "ArtsValley is mobile sharing platform particularly for sharing artwork. Here the artist can send their artwork and the viewers will like their artwork.",
      img: 'assets/images/av_info.png',
      uploadImg1: 'assets/images/flame.png',
    ),
    ItemModel(
      discription: "Step 1: Click on the add button.",
      img: 'assets/images/Upload1.jpg',
      uploadImg1: 'assets/images/flame.png',
    ),
    ItemModel(
      discription: "Step 1: Click on \'Forget Password\'.",
      img: 'assets/images/forget_1.jpeg',
      uploadImg1: 'assets/images/flame.png',
    ),
  ];

// About AV...
  Widget faq1(String header, int index, {Image image, bool isImage = false}) {
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 1000),
      dividerColor: Colors.red,
      elevation: 1,
      children: [
        //TODO: expansion panel here
        ExpansionPanel(
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 300,
                  child: Image.asset(
                    itemData[index].img,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  itemData[index].discription,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                isImage
                    ? Container(
                        height: 300,
                        child: Image.asset(
                          itemData[index].uploadImg1,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Text(
                header,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            );
          },
          isExpanded: itemData[index].expanded,
        ),
      ],
      expansionCallback: (int item, bool status) {
        setState(() {
          itemData[index].expanded = !itemData[index].expanded;
        });
      },
    );
  }

// Upload Post...
  Widget faq2(String header, int index, {Image image, bool isImage = false}) {
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 1000),
      dividerColor: Colors.red,
      elevation: 1,
      children: [
        ExpansionPanel(
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Step1...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    itemData[index].img,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  itemData[index].discription,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                //Step2...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Step 2: If you want to select your post from phone then select Gallery. \n OR \n If you want to click your post now, click on Camera.',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                //Step3...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload3.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Step 3: Select post from your storage.',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                // Step4...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload4.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Step 4: The selected photo will on ArtsValley.\nHere you can also reselect photo, and also you can edit your photo by clicking on edit button on top right corner.',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                // Step5...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload5.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Step 5: Here you can edit your photo. You can crop, resize, and rotate your photo.',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                // Step6...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload9.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Step 6: After clicking on \'Upload Image\' you\'ll jump on Caption page. Here write caption for your post.',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                //Step7...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload10.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Step 7: After clicking on \'Share\' you have successfully uploaded your post on \'ArtsValley\'.\n\nBelow you can check your post on \'Profile Page\' as well on \'Home Page.\'',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload11.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/Upload12.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Text(
                header,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            );
          },
          isExpanded: itemData[index].expanded,
        ),
      ],
      expansionCallback: (int item, bool status) {
        setState(() {
          itemData[index].expanded = !itemData[index].expanded;
        });
      },
    );
  }

// Reset Password...
  Widget faq3(String header, int index, {Image image, bool isImage = false}) {
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 1000),
      dividerColor: Colors.red,
      elevation: 1,
      children: [
        ExpansionPanel(
          body: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Step1...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    itemData[index].img,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  itemData[index].discription,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                //Step2...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/forget_2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Step 2: Enter your registered email ID.',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
                //Step3...
                Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                    'assets/images/forget_3.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Step 3: Reset your password',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      letterSpacing: 0.3,
                      height: 1.3),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Text(
                header,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            );
          },
          isExpanded: itemData[index].expanded,
        ),
      ],
      expansionCallback: (int item, bool status) {
        setState(() {
          itemData[index].expanded = !itemData[index].expanded;
        });
      },
    );
  }
}
