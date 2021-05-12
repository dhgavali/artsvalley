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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //pop
          },
        ),
        title: Text(
          'Registration Status',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[900],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.done_outline,
            size: 50,
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
        ],
      ),
    );
  }
}

//Registration Completed , Thank you For showing interest in our community we'll notify you soon. stay connected .
