import 'package:artsvalley/views/posts/showuserpost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserImageWidget extends StatelessWidget {
  final int index;
  final String posturl;
  final String postId;
  UserImageWidget(
      {@required this.index,
      this.postId,
      this.posturl,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("post opened");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowUserPost(
                      postId: postId,
                    )));
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
