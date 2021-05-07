import 'package:artsvalley/views/showpost.dart';
import 'package:artsvalley/views/showuserpost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserImageWidget extends StatelessWidget {
  final int index;
  final String posturl;
  final String postId;
  final String userId;
  final String caption;
  final String likescount;

  UserImageWidget(
      {@required this.index,
      this.postId,
      this.posturl,
      this.userId,
      this.caption,
      this.likescount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowUserPost(
              imageurl: posturl,
              caption: caption ?? '',
              likesCount: 10,
              postid: postId,
            ),
          ),
        );
      },
      
      child: Container(
        height: 150,
        child: Card(
          child: FadeInImage(
            image: (posturl.isNotEmpty)
                ? NetworkImage(this.posturl)
                : AssetImage("assets/images/painter.png"),
            placeholder: AssetImage("assets/images/painter.png"),
          ),
          
        ),
      ),
    );
  }
}
