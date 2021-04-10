import 'package:artsvalley/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MailSent extends StatefulWidget {
  final email;
  MailSent(this.email);

  @override
  _MailSentState createState() => _MailSentState();
}

class _MailSentState extends State<MailSent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120.0, left: 17.0, right: 17.0),
          child: Column(
            children: <Widget>[
              Text(
                'Password reset email sent',
                style: TextStyle(
                  fontSize: 28.00,
                  fontWeight: FontWeight.bold,
                
                ),
              ),
              SizedBox(height: size.height * 0.05),
              RichText(
                text: TextSpan(
                  text: 'We sent instructions to pick new password to ',
                  style: TextStyle(fontSize: 19.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${widget.email}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
              RichText(
                text: TextSpan(
                  text: "Didn't get the email? ",
                  style: TextStyle(fontSize: 19.0, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Tap here to resend it.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await context
                                .read<AuthMethods>()
                                .resetPassword(widget.email);
                          }),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.08),
              MaterialButton(
                color: Colors.teal[300],
                elevation: 0,
                
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Text(
                    'Go to login page',
                    style: TextStyle(
                      fontSize: 20.00, 
                      letterSpacing: 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
