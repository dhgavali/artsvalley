import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/views/btm_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomPostWidget extends StatefulWidget {
  final String profileurl;
  final String username;
  final String posturl;
//   //it may be string or int. we will use one which works easily and then typecast at server level or at UI level
  final int likescount;
  final String postId;
  final String caption;
  final String userId;
  final Function onLiked;
  final bool isLiked;
  final Map likes;

  CustomPostWidget(
      {this.profileurl,
      this.username,
      this.posturl,
      this.likescount,
      this.caption,
      this.postId,
      this.userId,
      this.onLiked,
      this.likes,
      this.isLiked});

  @override
  _CustomPostWidgetState createState() => _CustomPostWidgetState();
}

class _CustomPostWidgetState extends State<CustomPostWidget> {
  int likescount;
  bool isLiked;

  final GlobalKey<PopupMenuItemState> _popupKey =
      GlobalKey<PopupMenuItemState>();
  doLike() {
    var _currentUser = Provider.of<User>(context, listen: false).uid;
    bool _isliked = widget.likes[_currentUser] == true;
    if (_isliked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postId)
          .update({'likes.$_currentUser': FieldValue.delete()});
      setState(() {
        likescount -= 1;
        isLiked = false;
        widget.likes[_currentUser] = false;
      });
    } else {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postId)
          .update({'likes.$_currentUser': true});
      setState(() {
        likescount += 1;
        isLiked = true;
        widget.likes[_currentUser] = true;
      });
    }
  }

  @override
  void initState() {
    likescount = widget.likescount;
    isLiked = widget.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("custom post widget");
    double postHeight = (widget.caption.isEmpty) ? 525.0 : 550.0;
    if (widget.caption.length > 80) {
      postHeight += 15;
    }
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: postHeight,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(2.0, 3.0),
              color: Color(0xff303030),
              // color: kpostBorderColor,
              blurRadius: 5.0,
            ),
          ],
          color: Colors.white),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: (widget.profileurl == null)
                            ? AssetImage(
                                "assets/images/profile.png",
                              )
                            : NetworkImage(widget.profileurl),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.username ?? "username",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    //     InkWell(

                    //       child: Padding(
                    //         padding: const EdgeInsets.only(right: 10.0),
                    //         child: Icon(
                    //           Icons.more_vert,
                    //           color: Colors.white,
                    //           size: 30,
                    //         ),
                    //       ),
                    //     )

                    PopupMenuButton(
                        color: Colors.white,
                        iconSize: 30,
                        key: _popupKey,
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
                          if (value == 0) {
                            // edit post;
                            // moveToPage(context, pageName)
                          }
                          if (value == 1) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Confirm delete"),
                                    content: Text(
                                        "Are you sure want to delete your post"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await Provider.of<DatabaseService>(
                                                  context,
                                                  listen: false)
                                              .deletePost(widget.postId);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DesignBTMMyHomePage(),
                                              ),
                                              (route) => false);
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem<int>(
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 10),
                                  Text("Edit post"),
                                ],
                              ),
                              value: 0,
                            ),
                            PopupMenuItem<int>(
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 10),
                                  Text("Delete post"),
                                ],
                              ),
                              value: 1,
                            ),
                          ];
                        }),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 400,
            child: FadeInImage(
              image: (widget.posturl.length > 1)
                  ? NetworkImage(widget.posturl)
                  : AssetImage("assets/images/painter.png"),
              placeholder: AssetImage("assets/images/painter.png"),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.black87,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          doLike();
                        },
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 40,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        // "${widget.likescount}",
                        likescount.toString(),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.caption,
                      style: TextStyle(color: Colors.white),
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
