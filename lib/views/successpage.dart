import 'package:artsvalley/profile_page/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: a page which will be shown after the posting a arts. that you have successfully shared a post. something may be animated icon or anything similar.
class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Text("Uploaded Successfully"),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (builder) => Profile()),
                );
              },
              child: Text("Back to Profile"),
            )
          ],
        ),
      ),
    );
  }
}
