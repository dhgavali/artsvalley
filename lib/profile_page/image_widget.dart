import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../views/postwidget.dart';

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
  print("post url");
  print(posturl);
  print("userid :$userId");
      return Container(
        height: 150,
        child: Card(
          child: FadeInImage(
            image: (posturl.isNotEmpty)
                ? NetworkImage(this.posturl)
                : AssetImage("assets/images/painter.png"),
            placeholder: AssetImage("assets/images/painter.png"),
          ),
          // child: Image.network(
          //   'https://source.unsplash.com/random?sig=$index',
          //   fit: BoxFit.cover,
          // ),
        ),
      );
  }
}
