import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShowUserPost extends StatefulWidget {
  final String imageurl;
  final int likesCount;
  final String caption;
  final String postid;
  final String name;
  final String profileimage;
  final Map likes;
  final bool isLiked;

  ShowUserPost(
      {this.imageurl,
      this.likesCount,
      this.caption,
      this.postid,
      this.name,
      this.profileimage,
      this.likes,
      this.isLiked});

  @override
  _ShowUserPostState createState() => _ShowUserPostState();
}

class _ShowUserPostState extends State<ShowUserPost> {
  final List tags = ['Art', 'Potrait'];

  int likescount = 0;
  bool isLiked = false;

  doLike() {
    String _currentUser = Provider.of<User>(context, listen: false).uid;
    bool _isliked = widget.likes[_currentUser] == true;

    print(widget.likes);
    if (_isliked) {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postid)
          .update({'likes.$_currentUser': FieldValue.delete()});
      setState(() {
        likescount -= 1;
        isLiked = false;
        widget.likes[_currentUser] = false;
      },);
    } else {
      FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.postid)
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    //header
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Colors.black26)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: (widget.profileimage != null)
                              ? NetworkImage(widget.profileimage)
                              : AssetImage('assets/images/profile.png'),
                        ),
                        title: Text(
                          widget.name,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //image
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height * 0.55,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black26,
                        ),
                      ),
                      child: FadeInImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.imageurl,
                        ),
                        placeholder: AssetImage('assets/images/painter.png'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          vertical:
                              BorderSide(width: 0.5, color: Colors.black26),
                        ),
                      ),
                      child: Column(
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  widget.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                onPressed: () {
                                  //TODO: Like functionality here
                                  doLike();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  '${widget.likesCount}',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //footor
                          Container(
                            padding: EdgeInsets.only(bottom: 15),
                            margin: EdgeInsets.only(left: 15, right: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.caption,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
