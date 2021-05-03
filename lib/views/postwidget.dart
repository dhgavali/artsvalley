import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/userprofile.dart';
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

// //This is the constructor for this class which initializes the values that are required to create a post template.
// // These are named parameters so at the time of calling the constructor you will get hint what to pass to the constructor no need to remember.
// // This constructor will be called at homepage inside a streambuilder where a values will be fetched from the datbase and then passed to this constructor.
// //There are required some fixes in this that i have mentioned at the end of this page.
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
  DocumentSnapshot likeRef;
  bool isLiked = false;
  // bool isLiked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  doLike() {
    String _currentUser = Provider.of<User>(context, listen: false).uid;
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
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 500,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(5, 5),
              color: Color(0xff303030),
              blurRadius: 10,
            ),
          ],
          color: Colors.white),
      child: Stack(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage(
                          userid: widget.userId,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        //TODO: Here implement the gestureDetector which will be invoked on click of the profile photo. as user click on profile photo a viewProfile will be opened. This profile page will be view only. Which will shown the user profile. Basically we have two types of profile pages. One is for the user itself. Where he can change his details update the data or profile photo. and other one is to display to other users. which will show only read only information. and may be we can do a follow option. or we need to find something different than follow. but initially we need to show the details.
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
                        //TODO: The text widget here represents the username. we need to get this from database.
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
                      child: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          //TODO: done
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 55),
            constraints: BoxConstraints.expand(
              height: 300,
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //TODO: this is the image fetched from the database which is user post.
            child: FadeInImage(
              image: (widget.posturl.length > 1)
                  ? NetworkImage(widget.posturl)
                  : AssetImage("assets/images/painter.png"),
              placeholder: AssetImage("assets/images/painter.png"),
            ),
          ),
          Row(
            children: [
              
            ],
          )
          ,
          //TODO: we need to add these icons with changable colors on tap. based on that we need to increment likes or decrement on server and also change the saving priority
          // Positioned(
          //   bottom: 60,
          //   right: 10,
          //   child: Icon(
          //     Icons.share,
          //     size: 40,
          //     color: Colors.teal,
          //   ),
          // ),
          // Positioned(
          //   bottom: 60,
          //   left: 10,
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       InkWell(
          //         //TODO : here is like functionality
          //         onTap: () {
          //           doLike();
          //           // widget.onLiked;
          //           // DatabaseService().updateLikesDB(widget.postId,
          //           // log(widget.isLiked.toString());
          //           //     Provider.of<User>(context, listen: false).uid, true);
          //         },

          //         child: Icon(
          //           widget.isLiked ? Icons.favorite : Icons.favorite_border,
          //           size: 40,
          //           color: Colors.redAccent,
          //         ),
          //       ),
          //       Text(
          //         // _likeProvider.count.toString(),
          //         //
          //         // "${widget.likescount}",
          //         "${widget.likescount}",
          //         style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          //       )
          //     ],
          //   ),
          // ),
          // Positioned(
          //   top: 450,
          //   left: 16,
          //   child: Container(
          //     //TODO: needs to fix this text. When the text is bigger than width we need to adjust it to multiline text. So the text will be displayed on next line automatically. and after 3 lines the readmore button will be shown for the longer captions. So when clicked on readmore text will expand to full size page
          //     child: Text(
          //       "${widget.caption}",
          //       overflow: TextOverflow.visible,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

//The fixes:
// 1. we need to check that image quality is maintained based on the data / network speed
// 2. We need to insure that if image failed to load then it will reload after receiving a network.
// 3. Image should not overflow out of the box. we need to display full image not cropped inside the layout.
// 4. other things are mentioned in todo kindly check that.
