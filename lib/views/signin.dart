import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/loading.dart';
import 'package:artsvalley/views/home.dart';
import 'package:artsvalley/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: Icon(Icons.verified_user),
              title: Text("Sign In"),
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      customInputField(
                          "username", Icons.person, usernameController),
                      customInputField("password", Icons.visibility_off,
                          pwdController, true),

                      //login button
                      Container(
                        width: ProConstants.buttonWidth,
                        height: ProConstants.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await context.read<AuthMethods>().signIn(
                                  email: usernameController.text.trim(),
                                  password: pwdController.text.trim(),
                                );

                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((User user) {
                              if (user != null) {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text("failed to login"),
                                );
                              }
                            });
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            // if (mounted) {
                            //   setState(() {
                            //     _isLoading = true;
                            //   });
                            // }
                            await context
                                .read<AuthMethods>()
                                .signInWithGoogle();
                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((User user) {
                              if (user != null) {
                                if (mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                return Center(
                                  child: Text("failed to login"),
                                );
                              }
                            });
                          },
                          child: googleWidget()),

                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Text(
                          "Not Have an Account? ",
                          style: TextStyle(
                            fontSize: ProConstants.headingsize - 2,
                            letterSpacing: 1.5,
                            color: Color(0xff212121),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            );
                          },
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                                fontSize: ProConstants.headingsize,
                                decorationStyle: TextDecorationStyle.solid,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget googleWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: ProConstants.buttonWidth,
      height: ProConstants.buttonHeight,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 5.0,
              color: ProConstants.shadowColor),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/images/googlemini.png"),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "Continue with Google",
            style: TextStyle(
              fontSize: ProConstants.buttonfontsize,
              color: ProConstants.bgcolor,
            ),
          )
        ],
      ),
    );
  }

  // checkData() {
  // context.read<AuthenticationService>().signIn(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  // }
}
