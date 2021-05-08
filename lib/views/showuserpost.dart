import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowUserPost extends StatelessWidget {
  final String imageurl;
  final int likesCount;
  final String caption;
  final String postid;
  final String name;
  final String profileimage;
  final List tags = ['Art', 'Potrait'];

  ShowUserPost(
      {this.imageurl,
      this.likesCount,
      this.caption,
      this.postid,
      this.name,
      this.profileimage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
<<<<<<< HEAD
                      height: MediaQuery.of(context).size.height * 0.52,
=======
                      height: MediaQuery.of(context).size.height * 0.70,
>>>>>>> 8dfaa1dbaed6daf27aeceb58065e77111a90e6b3
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
<<<<<<< HEAD
                          border: Border.symmetric(
                              vertical: BorderSide(
                                  width: 0.5, color: Colors.black26))),
=======
                        border: Border.symmetric(
                          vertical:
                              BorderSide(width: 0.5, color: Colors.black26),
                        ),
                      ),
>>>>>>> 8dfaa1dbaed6daf27aeceb58065e77111a90e6b3
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
            ],
          ),
        ),
      ),
    );
  }
}
