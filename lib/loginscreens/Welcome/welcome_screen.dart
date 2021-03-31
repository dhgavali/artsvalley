import 'package:artsvalley/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/loginscreens/Signup/signup_screen.dart';
import 'package:artsvalley/loginscreens/Welcome/components/body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final _controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          SignUpScreen(),
          WelcomeBody(),
          LoginScreen(),
        ],
      ),
    );
  }
}
