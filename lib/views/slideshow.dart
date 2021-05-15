import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideShow extends StatelessWidget {
  Container slides(String posturl, String authorName, String username) {
    return Container(
      width: 160.0,
      child: Card(

        child: Wrap(

          children: [
            Image.network(posturl),
            ListTile(
              title: Text(authorName),
              subtitle: Text(username),
            ),
          ],
        ),
      ),
    );
  }

  Future getSlideshowImageFromdb() async {
    var _firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _firestore.collection('posts').get();

    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Top Posts',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getSlideshowImageFromdb(),
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot slideimg = snapshot.data[index];
                      Map getImage = slideimg.data();
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        //height: 300,
                        child: slides(getImage['postUrl'], 'Dh Gavali', getImage['username']),
                      );
                    });
          }),
    );
  }
}
