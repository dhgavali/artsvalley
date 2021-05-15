import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/btm_animated.dart';
import 'package:artsvalley/views/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoftifyUser extends StatefulWidget {
  @override
  _NoftifyUserState createState() => _NoftifyUserState();
}

class _NoftifyUserState extends State<NoftifyUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration Status',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Registration Completed",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Icon(
            Icons.done,
            size: 125,
            color: Colors.teal,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: Text(
                "Registration Completed , Thank you For showing interest in our community we'll notify you soon. stay connected .",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    height: 1.5,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DesignBTMMyHomePage()),
                  (route) => false);
            },
            child: Text("Back To Profile"),
          ),
        ],
      ),
    );
  }
}

//Registration Completed , Thank you For showing interest in our community we'll notify you soon. stay connected .
