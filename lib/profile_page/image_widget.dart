import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/posts/showpost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageWidget extends StatelessWidget {
  final int index;
  final String posturl;
  final String postId;
  final String userId;

  ImageWidget({
    @required this.index,
    this.postId,
    this.posturl,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        moveToPage(
            context,
            ShowPost(
              postId: postId,
            ));
      },
      child: Container(
        height: 150,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black26, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
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
