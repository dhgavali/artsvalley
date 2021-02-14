import 'package:artsvalley/views/constants.dart';
import 'package:artsvalley/views/shared_widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign UP"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              customInputField(
                "Email Id",
                Icon(Icons.email),
              ),
              customInputField(
                "Password",
                Icon(Icons.visibility),
              ),
              customInputField(
                "Confirm Password",
                Icon(Icons.visibility),
              ),
              SizedBox(height: 10),
              loginButton("Sign Up"),

              //TODO: here we will create a row which will show the google and facebook icon for sign up purpose.
            ],
          ),
        ),
      ),
    );
  }
}
