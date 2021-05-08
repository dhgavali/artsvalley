import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  static String routeName = "/about_us";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet our Team"),
      ),
      body: ListView(
        children: <Widget>[
          UserCardWidget(
            photoUrl: "assets/team/dh.png",
            name: "Dhananjay Gavali",
            caption: "Team Leader",
          ),
          UserCardWidget(
            photoUrl: "assets/team/dark2.png",
            name: "Abhishek Tavhare",
            caption: "Backend Developer",
          ),
          UserCardWidget(
            photoUrl: "assets/team/dark2.png",
            name: "Upendra Taral",
            caption: "UI Developer",
          ),
          UserCardWidget(
            photoUrl: "assets/team/dark2.png",
            name: "Rohan Yadav",
            caption: "UI Designer",
          ),
          UserCardWidget(
            photoUrl: "assets/team/dark2.png",
            name: "Dhananjay Gavali",
            caption: "Team Leader",
          ),
        ],
      ),
    );
  }
}

class UserCardWidget extends StatelessWidget {
  final String photoUrl;
  final String name;
  final String caption;
  final LinearGradient gradient;

  const UserCardWidget({this.photoUrl, this.name, this.caption, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width) * 0.1,
        vertical: 20,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(5, 5),
            color: Color(0xff303030),
            blurRadius: 10,
          ),
          BoxShadow(
            offset: Offset(5, 5),
            color: Color(0xff303030),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 170,
            height: 170,
            child: CircleAvatar(
              backgroundImage: AssetImage("$photoUrl"),
              backgroundColor: Colors.transparent,
            ),
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(colors: [
                    Color(0xFF7FC6A4),
                    Color(0xFF2978A0),
                  ]),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(3, 3),
                  color: Color(0xff303030),
                  blurRadius: 11.5,
                ),
              ],
            ),
          ),
          Text(
            name,
            style: GoogleFonts.pacifico(
                fontWeight: FontWeight.normal,
                fontSize: 28,
                letterSpacing: 2.0),
          ),
          Text(
            caption,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}