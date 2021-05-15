import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
import 'package:artsvalley/profile_page/newDesignProfile/newUserProfile.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/report_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class PostWidget extends StatefulWidget {
  final String profileurl;
  // //either we will display a username or full name here
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

  PostWidget(
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
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  int likescount = 0;
  // DocumentSnapshot likeRef;
  bool isLiked = false;
  final GlobalKey<PopupMenuItemState> _popupKey =
      GlobalKey<PopupMenuItemState>();
  bool isSaved;

  //save method here
  doSave(bool isSavedDb) {
    DocumentReference _ref = FirebaseFirestore.instance
        .collection("favorites")
        .doc(Provider.of<User>(context, listen: false).uid);

    String _currentUser = Provider.of<User>(context, listen: false).uid;
    if (isSavedDb) {
      _ref.set({'saved.$_currentUser': FieldValue.delete()});
      setState(() {
        // widget.likes[_currentUser] = false;
        isSaved = false;
      });
    } else {
      _ref.set({'saved.$_currentUser': true});
      setState(() {
        // widget.likes[_currentUser] = true;
        isSaved = true;
      });
    }
  }

  doLike() {
    var _currentUser = Provider.of<User>(context, listen: false);
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
    // DocumentSnapshot ds = await FirebaseFirestore.instance
    //     .collection("favorites")
    //     .doc(Provider.of<User>(context, listen: false).uid)
    //     .get();
    // isSaved = ds.data()['favorites'].containsKey(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _userProvider = Provider.of<User>(context, listen: false);
    print(_userProvider.uid);
    double postHeight = (widget.caption.isEmpty) ? 425.0 : 450.0;
    if (widget.caption.length > 80) {
      postHeight += 15;
    }
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: postHeight,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(5, 5),
              color: Color(0xff303030),
              // color: kpostBorderColor,
              blurRadius: 10,
            ),
          ],
          color: Colors.white),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
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
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.black87,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              doLike();
                            },
                            child: Icon(
                              widget.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 40,
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
                      ),

                      ///
                      ///
                      ///TODO: save and unsave here
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("favorites")
                              .doc(_userProvider.uid)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            return InkWell(
                              onTap: () {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                  
                                    doSave(true);
                                  }
                                }
                              },
                              child: Icon(
                                isSaved
                                    ? Icons.bookmark_outlined
                                    : Icons.bookmark_border,
                                size: 35,
                                color: Colors.white,
                              ),
                            );
                          })
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
