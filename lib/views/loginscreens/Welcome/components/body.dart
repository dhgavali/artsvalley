import 'package:artsvalley/views/loginscreens/Login/background.dart';
import 'package:artsvalley/views/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/views/loginscreens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/shared/constants.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            Image(
              width: size.width - 120,
              image: AssetImage("assets/images/logo.png"),
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
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
                color: kteagreen2,
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
