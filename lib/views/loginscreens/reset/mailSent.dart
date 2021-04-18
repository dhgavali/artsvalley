import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/views/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MailSent extends StatelessWidget {
  final email;
  MailSent(this.email);

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
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'We sent instructions to pick new password to ',
                    style: Theme.of(context).textTheme.bodyText1,
                    children: <TextSpan>[
                      TextSpan(
                        text: '$email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
                                .resetPassword(email)
                                .then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Sent Sucessfully"),
                              ));
                            });
                          }),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.08),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (context) => LoginScreen()));
                },
                child: RoundedButton(
                  text: "Go to Login Page",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
