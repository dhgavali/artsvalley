import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShowPost extends StatelessWidget {
  final String imageurl;
  final String name;
  final int likesCount;
  final String caption;
  final String postid;
  final String profileimage;
  final List tags = ['Art', 'Potrait'];

  ShowPost(
      {this.imageurl,
      this.name,
      this.likesCount,
      this.caption,
      this.postid,
      this.profileimage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    //header
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Colors.black26)),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: (profileimage != null)
                              ? NetworkImage(profileimage)
                              : AssetImage('assets/images/profile.png'),
                        ),
                        title: Text(
                          name,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //image
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.black26,
                        ),
                      ),
                      child: FadeInImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          imageurl,
                        ),
                        placeholder: AssetImage('assets/images/painter.png'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.symmetric(
                              vertical: BorderSide(
                                  width: 0.5, color: Colors.black26))),
                      child: Column(
                        children: [
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 40,
                                ),
                                onPressed: () {},
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  '$likesCount',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //footor
                          Container(
                            padding: EdgeInsets.only(bottom: 15),
                            margin: EdgeInsets.only(left: 15, right: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              caption,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                color: Colors.grey,
                icon: Icon(
                  Icons.delete_forever,
                  size: 40,
                ),
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
                                  //TODO: use pushandremoveuntil here
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfilePageNew()));
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
              Text(
                'Delete Post',
                style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
