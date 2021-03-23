import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmController = new TextEditingController();
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
                  "Email Id", Icons.email, emailController),
              customInputField(
                  "Password", Icons.visibility, passwordController, true),
              customInputField(
                  "Confirm Password",
                    Icons.visibility,
                
                  confirmController,
                  true),
              SizedBox(height: 10),
              Container(
                width: ProConstants.buttonWidth,
                height: ProConstants.buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthMethods>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());

                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User user) {
                      if (user != null) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      } else {
                        return Center(
                          child: Text("failed to login"),
                        );
                      }
                    });

                    // context.read<AuthMethods>().signUp(
                    //       email: emailController.text.trim(),
                    //       password: passwordController.text.trim(),
                    //     );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),

              //TODO: here we will create a row which will show the google and facebook icon for sign up purpose.
            ],
          ),
        ),
      ),
    );
  }

  validateInputs() {}
}
