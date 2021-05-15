import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SubmitMsgForPortraitForm extends StatefulWidget {
  @override
  _SubmitMsgForPortraitFormState createState() => _SubmitMsgForPortraitFormState();
}

class _SubmitMsgForPortraitFormState extends State<SubmitMsgForPortraitForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Status',
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
              "Your Order Is Placed",
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
                "Order Placed Successfully , Thank you For showing interest in our community we'll notify you soon with your portrait when its ready until then ,stay connected stay happy 😉😊.",
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
                  MaterialPageRoute(builder: (context) => HomePage()),
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
