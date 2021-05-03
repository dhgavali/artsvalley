import 'package:flutter/material.dart';

class ShowPost extends StatelessWidget {
  final String imageurl;
  final int likesCount;
  final String caption;
  final List tags = ['Art', 'Potrait'];

  ShowPost({Key key, this.imageurl, this.likesCount, this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 300,
              child: FadeInImage(
                image: NetworkImage(imageurl),
                placeholder: AssetImage('assets/images/painter.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
