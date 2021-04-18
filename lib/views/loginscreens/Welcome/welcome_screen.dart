import 'package:artsvalley/views/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/views/loginscreens/Signup/signup_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

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
