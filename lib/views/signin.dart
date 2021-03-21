import 'package:artsvalley/constant/constants.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artsvalley/views/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(Icons.verified_user),
        title: Text("Sign In"),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                customInputField(
                    "username", Icon(Icons.person), usernameController),
                customInputField(
                    "password", Icon(Icons.visibility_off), pwdController),
                loginButton("Login", checkData),
                GestureDetector(
                    onTap: () async {
                      Center(child: CircularProgressIndicator());

                      context.read<AuthMethods>().signInWithGoogle();

                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User user) {
                        if (user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        } else {
                          return Center(
                            child: Text("failed to login"),
                          );
                        }
                      });
                    },
                    child: googleWidget()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget googleWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: ProConstants.buttonWidth,
      height: ProConstants.buttonHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 10.0,
              color: Color(0xff909090)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/images/googlemini.png"),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "Continue with Google",
            style: TextStyle(fontSize: ProConstants.buttonfontsize),
          )
        ],
      ),
    );
  }

  checkData() {}
}
