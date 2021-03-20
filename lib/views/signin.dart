import 'package:artsvalley/views/shared_widgets.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.verified_user),
        title: Text("Sign In"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customInputField(
                "username", Icon(Icons.person), usernameController),
            customInputField(
                "password", Icon(Icons.visibility_off), pwdController),
            loginButton("Login", checkData),

            //TODO: here we will create a row which will show the google and facebook icon for Login purpose.
          ],
        ),
      ),
    );
  }

  checkData(){
      
  }
}
