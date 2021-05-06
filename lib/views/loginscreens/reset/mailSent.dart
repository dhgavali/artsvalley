import 'dart:async';

import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/helper/sizeconfig.dart';
import 'package:artsvalley/views/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MailSent extends StatelessWidget {
  final email;
  MailSent(this.email);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.done),
        title: Text("Mail Sent"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 00.0, left: 17.0, right: 17.0),
          child: Column(
            children: <Widget>[
             SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Password Resent Mail Sent",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(26),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
              SizedBox(
                height: 5,
              ),
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
