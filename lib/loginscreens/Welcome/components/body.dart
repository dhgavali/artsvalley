import 'package:flutter/material.dart';
import 'package:artsvalley/loginScreens/Login/login_screen.dart';
import 'package:artsvalley/loginScreens/Signup/signup_screen.dart';
import 'package:artsvalley/loginScreens/Welcome/components/background.dart';
import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO ARTS VALLEY",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: RoundedButton(
                text: "LOGIN",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
              child: RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
