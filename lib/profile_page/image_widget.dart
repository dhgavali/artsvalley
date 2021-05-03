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
        print("post clicked");
        print("post id: $posturl");
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
