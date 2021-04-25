import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/providers/usersdata.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/services/sharedPref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CaptionPost extends StatefulWidget {
  @override
  _CaptionPostState createState() => _CaptionPostState();
}

class _CaptionPostState extends State<CaptionPost> {
  TextEditingController captionController = new TextEditingController();
  SharedPrefHelper _prefs = new SharedPrefHelper();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);

    final mq = MediaQuery.of(context);
    final bottomOffset = mq.viewInsets.bottom + mq.padding.bottom;
    const curve = Curves.easeInOutCirc;
    const duration = 275;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedContainer(
        curve: curve,
        duration: const Duration(milliseconds: duration),
        padding: EdgeInsets.only(bottom: bottomOffset),
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.file(
                            Provider.of<UploadPost>(context, listen: false)
                                .uploadPostImage,
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
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: 30.00,
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
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 120,
                            controller: captionController,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Add a caption",
                              hintStyle: TextStyle(
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: MaterialButton(
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
                      print("upload post time");
                      print("Current user is: ");
                      print(user.email);
                      var uid =
                          Provider.of<UploadPost>(context, listen: false).uuid;
                      String _postid = uid.v1();
                      Provider.of<DatabaseService>(context, listen: false)
                          .uploadPostData({
                        'caption': captionController.text.trim(),
                        'userId': user.uid,
                        'postUrl':
                            Provider.of<UploadPost>(context, listen: false)
                                .uploadPostImageUrl,
                        'likes': 0,
                        'postId': _postid,
                        'username': Provider.of<UserDataProvider>(context,
                                listen: false)
                            .usern,
                        'userProfile': Provider.of<UserDataProvider>(context,
                                listen: false)
                            .userprof,
                      }, _postid).whenComplete(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Profile()),
                            (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
