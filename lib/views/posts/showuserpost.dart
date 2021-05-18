import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artsvalley/services/fetchpostdata.dart';
import 'package:artsvalley/models/postmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/views/posts/userpostwidget.dart';

class ShowUserPost extends StatefulWidget {
  final String postId;

  ShowUserPost({this.postId});

  @override
  _ShowUserPostState createState() => _ShowUserPostState();
}

class _ShowUserPostState extends State<ShowUserPost> {
  int likescount = 0;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder<DocumentSnapshot>(
            future: FetchPostData(postId: widget.postId).postDataUrl,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              print("inside the builder");
              // PostDataModel postData = snapshot.data;
              print(widget.postId);
              if (snapshot.connectionState == ConnectionState.none ||
                  snapshot.connectionState == ConnectionState.waiting) {
                print("watiting");
                return LinearProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  // PostDataModel postdata = snapshot.data;
                  PostDataModel postdata =
                      FetchPostData().convertDocument(snapshot.data);

                  print("snapshot has data");
                  Map likescount = postdata.likes;
                  String currentUser =
                      Provider.of<User>(context, listen: false).uid;
                  bool isLiked = likescount[currentUser] == true;
                  return UsersPostWidget(
                    caption: postdata.caption,
                    username: postdata.username,
                    userId: postdata.userId,
                    profileurl: postdata.userProfile,
                    postId: postdata.postId,
                    posturl: postdata.postUrl,
                    likes: postdata.likes,
                    isLiked: isLiked,
                    likescount: postdata.likes.length,
                  );
                }
              }

              return LinearProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
