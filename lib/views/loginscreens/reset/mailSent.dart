import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/helper/sizeconfig.dart';
import 'package:artsvalley/shared/constants.dart';
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
      appBar: AppBar(
        leading: Icon(Icons.done),
        title: Text("Mail Sent"),
      ),
      body: Center(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  text: 'We sent instructions to pick new password to  ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '$email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            RichText(
              text: TextSpan(
                text: "Didn't get the email? ",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: "Tap here to resend it.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
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
            SizedBox(height: size.height * 0.06),
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
    );
  }
}
