// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class ShowUserPost extends StatefulWidget {
//   final String imageurl;
//   final int likesCount;
//   final String caption;
//   final String postid;
//   final String name;
//   final String profileimage;
//   final Map likes;
//   final bool isLiked;

//   ShowUserPost(
//       {this.imageurl,
//       this.likesCount,
//       this.caption,
//       this.postid,
//       this.name,
//       this.profileimage,
//       this.likes,
//       this.isLiked});

//   @override
//   _ShowUserPostState createState() => _ShowUserPostState();
// }

// class _ShowUserPostState extends State<ShowUserPost> {
//   final List tags = ['Art', 'Potrait'];

//   int likescount = 0;
//   bool isLiked = false;

//   doLike() {
//     String _currentUser = Provider.of<User>(context, listen: false).uid;
//     bool _isliked = widget.likes[_currentUser] == true;

//     print(widget.likes);
//     if (_isliked) {
//       FirebaseFirestore.instance
//           .collection("posts")
//           .doc(widget.postid)
//           .update({'likes.$_currentUser': FieldValue.delete()});
//       setState(
//         () {
//           likescount -= 1;
//           isLiked = false;
//           widget.likes[_currentUser] = false;
//         },
//       );
//     } else {
//       FirebaseFirestore.instance
//           .collection("posts")
//           .doc(widget.postid)
//           .update({'likes.$_currentUser': true});
//       setState(() {
//         likescount += 1;
//         isLiked = true;
//         widget.likes[_currentUser] = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Inside show user post");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Posts"),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             children: [
//               Card(
//                 child: Column(
//                   children: [
//                     //header
//                     Container(
//                       decoration: BoxDecoration(
//                           border:
//                               Border.all(width: 0.5, color: Colors.black26)),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: (widget.profileimage != null)
//                               ? NetworkImage(widget.profileimage)
//                               : AssetImage('assets/images/profile.png'),
//                         ),
//                         title: Text(
//                           widget.name,
//                           style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     //image
//                     Container(
//                       width: MediaQuery.of(context).size.width - 20,
//                       height: MediaQuery.of(context).size.height * 0.55,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           width: 0.5,
//                           color: Colors.black26,
//                         ),
//                       ),
//                       child: FadeInImage(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(
//                           widget.imageurl,
//                         ),
//                         placeholder: AssetImage('assets/images/painter.png'),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         border: Border.symmetric(
//                           vertical:
//                               BorderSide(width: 0.5, color: Colors.black26),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           // ButtonBar(
//                           //   alignment: MainAxisAlignment.start,
//                           //   children: [
//                           //     IconButton(
//                           //       icon: Icon(
//                           //         widget.isLiked
//                           //             ? Icons.favorite
//                           //             : Icons.favorite_border_outlined,
//                           //         color: Colors.red,
//                           //         size: 40,
//                           //       ),
//                           //       onPressed: () {
//                           //         //TODO: Like functionality here
//                           //         doLike();
//                           //       },
//                           //     ),
//                           //     Padding(
//                           //       padding: const EdgeInsets.only(top: 5.0),
//                           //       child: Text(
//                           //         '${widget.likesCount}',
//                           //         style: GoogleFonts.poppins(
//                           //           textStyle: TextStyle(
//                           //             fontSize: 25,
//                           //           ),
//                           //         ),
//                           //       ),
//                           //     ),
//                           //   ],
//                           // ),
//                           // //footor

//                           Row(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   doLike();
//                                 },
//                                 child: Icon(
//                                   widget.isLiked
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   size: 40,
//                                   color: Colors.redAccent,
//                                 ),
//                               ),
//                               Text(
//                                 "dflksf5",
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(bottom: 15),
//                             margin: EdgeInsets.only(left: 15, right: 10),
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               widget.caption,
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
import 'package:artsvalley/profile_page/newDesignProfile/newUserProfile.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/report_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class ShowUserPost extends StatefulWidget {
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

  ShowUserPost(
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
  _ShowUserPostState createState() => _ShowUserPostState();
}

class _ShowUserPostState extends State<ShowUserPost> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Container(
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
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
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
                      height: 70,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("posts")
                            .where("postId", isEqualTo: widget.postId)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          print("into the builder");
                          if (snapshot.connectionState ==
                                  ConnectionState.none ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return LinearProgressIndicator();
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              // snapshot.data.docs.map((e) => null);
                              print(snapshot.data.docs[1]);
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("method tapped");
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
                              );
                            }
                          }
                          return LinearProgressIndicator();
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
      ),
    );
  }
}
