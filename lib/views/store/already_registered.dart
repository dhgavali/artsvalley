import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/btm_animated.dart';
import 'package:artsvalley/views/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArleadyRegistered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Already Registered"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "You have already applied ",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ),
          Container(
            child: Text(
              "You application is under review !",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
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
                "Thank you For showing interest in our community we'll notify you soon. stay connected .",
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
