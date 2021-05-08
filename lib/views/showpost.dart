import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowPost extends StatelessWidget {
  final String imageurl;
  final int likesCount;
  final String caption;
  final String postid;
  final List tags = ['Art', 'Potrait'];

  ShowPost({Key key, this.imageurl, this.likesCount, this.caption, this.postid})
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
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.grey,
              child: Text("Delete Post"),
              onPressed: () {
                print(this.postid);
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title:
                            Text("Are you sure you want to delete this post"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Exit"),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<UploadPost>(context, listen: false)
                                  .deleteFromCloudAndDb(this.postid)
                                  .whenComplete(() {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Profile(),
                                    ),
                                    (route) => false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  new SnackBar(
                                    content: Text("Post Deleted"),
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                            },
                            child: Text('Continue'),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
