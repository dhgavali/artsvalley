import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/views/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/views/loginscreens/reset/mailSent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = new TextEditingController();
  final GlobalKey<FormState> _resetForm = GlobalKey<FormState>();

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return "Email can't be empty";
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }),
        title: Text('Reset Password'),
        centerTitle: true,
      ),
      body: Form(
        key: _resetForm,
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: customInputField1(
                    "Email",
                    Icons.email,
                    emailController,
                    emailValidator,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                GestureDetector(
                  onTap: () async {
                    if (_resetForm.currentState.validate()) {
                      try {
                        await context.read<AuthMethods>().resetPassword(
                              emailController.text.trim(),
                            );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MailSent(
                              emailController.text.trim(),
                            ),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        String error;
                        switch (e.code) {
                          case "user-not-found":
                            error =
                                'User account does not exists ! Make sure you entered registerd email.';
                            break;
                          case "too-many-requests":
                            error = "Too many request please try later";
                            break;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          new SnackBar(
                            backgroundColor: Colors.grey[300],
                            duration: Duration(seconds: 4),
                            content: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 26,
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    error,
                                    style: TextStyle(
                                      fontSize: 15.00,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: RoundedButton(
                    text: "Reset Password",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
