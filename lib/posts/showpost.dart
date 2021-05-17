import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
import 'package:artsvalley/profile_page/newDesignProfile/newUserProfile.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/report_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class ShowUsersPost extends StatefulWidget {
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

  ShowUsersPost(
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
  _ShowPostState createState() => _ShowPostState();
}

class _ShowPostState extends State<ShowUsersPost> {
  int likescount = 0;
  bool isLiked = false;
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
  Widget build(BuildContext context) {
    double postHeight = (widget.caption.isEmpty) ? 425.0 : 450.0;
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
                InkWell(
                  onTap: () {
                    if (Provider.of<User>(context, listen: false).uid ==
                        widget.userId) {
                      moveToPage(context, ProfilePageNew());
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewUserProfilePage(
                            userid: widget.userId,
                          ),
                        ),
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              (widget.profileurl.startsWith("assets/"))
                                  ? AssetImage(
                                      widget.profileurl,
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
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: PopupMenuButton(
                          color: Colors.white,
                          iconSize: 30,
                          key: _popupKey,
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          // onCanceled: () {},
                          onSelected: (value) {
                            if (value == 0) {
                              // print(value);
                              Navigator.push(
                                context,
                                moveToPage(
                                  context,
                                  ReportPage(
                                    postId: widget.postId,
                                  ),
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem<int>(
                                child: Text("Report"),
                                value: 0,
                              ),
                            ];
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            height: 300,
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
                  Container(
                    height: 60,
                    child: StreamBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    doLike();
                                    print("there it si");
                                  },
                                  child: Icon(
                                    widget.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 50,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Text(
                                  "${widget.likescount}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            );
                          }
                        }
                        return Container();
                      },
                    ),
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
