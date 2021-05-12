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
  final String profileurl;
  final String userdisplayname;
  final Map likes;
  final bool isLiked;
  UserImageWidget(
      {@required this.index,
      this.postId,
      this.posturl,
      this.userId,
      this.caption,
      this.likescount,
      this.profileurl,
      this.userdisplayname,
      this.likes,
      this.isLiked});

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
              likesCount: int.parse(likescount),
              postid: postId,
              name: userdisplayname,
              profileimage: profileurl,
              isLiked: isLiked,
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
