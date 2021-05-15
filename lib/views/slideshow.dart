import 'package:artsvalley/profile_page/newDesignProfile/newUserProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlideShow extends StatelessWidget {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                'Top Posts',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              // fontsize of heading text is small so i used text widget here
              //headingtext('Top Posts')
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: getSlideshowImageFromdb(),
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: 350,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot slideimg =
                                    snapshot.data[index];
                                Map getImage = slideimg.data();

                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 5),
                                  child: slides(
                                    getImage['postUrl'],
                                    getImage['username'],
                                    context,
                                    getImage['userId'],
                                  ),
                                );
                              }),
                        );
                }),
            SizedBox(
              height: 25,
            ),
            Text(
              'Explore Users Posts',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            FutureBuilder(
                future: getSlideshowImageFromdb(),
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: 350,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot slideimg =
                                    snapshot.data[index];
                                Map getImage = slideimg.data();

                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 5),
                                  child: slides(
                                    getImage['postUrl'],
                                    getImage['username'],
                                    context,
                                    getImage['userId'],
                                  ),
                                );
                              }),
                        );
                }),
            SizedBox(
              height: 25,
            ),
            Text(
              'Random Posts',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            FutureBuilder(
                future: getSlideshowImageFromdb(),
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: 350,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot slideimg =
                                    snapshot.data[index];
                                Map getImage = slideimg.data();

                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 5),
                                  child: slides(
                                    getImage['postUrl'],
                                    getImage['username'],
                                    context,
                                    getImage['userId'],
                                  ),
                                );
                              }),
                        );
                }),
          ],
        ),
      ),
    );
  }

  Container slides(
      String posturl, String username, BuildContext context, String userid) {
    return Container(
      width: 160.0,
      child: Card(
        child: Wrap(
          children: [
            Image.network(
              posturl,
              height: 200,
            ),
            ListTile(
              onTap: () {
                openUserProfile(context, userid);
              },
              title: Text(
                username,
                style: GoogleFonts.poppins(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openUserProfile(BuildContext context, String userId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewUserProfilePage(
                  userid: userId,
                )));
  }
}
