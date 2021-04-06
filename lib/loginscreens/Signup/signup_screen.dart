import 'package:artsvalley/components/already_have_an_account_acheck.dart';
import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/components/text_field_container.dart';
import 'package:artsvalley/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/loginscreens/Signup/components/background.dart';
import 'package:artsvalley/loginscreens/Signup/components/or_divider.dart';
import 'package:artsvalley/providers/update_data_provider.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmController = new TextEditingController();

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

  String validateName(value) {
    var name = nameController.text;

    if (name.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  String validatePassword(value) {
    var pass = passwordController.text;
    var confirm = confirmController.text;
    if (pass != "" && pass == confirm) {
      if (pass.isEmpty) {
        return "Please enter a password";
      } else if (pass.length < 6) {
        return "Paswword should be atleast 6 characters ";
      } else if (pass.length > 15) {
        return "Password should not be greater than 15 characters";
      } else {
        return null;
      }
    } else {
      return "Please check that you've entered and confirmed your password!";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/signup.svg",
                  height: size.height * 0.35,
                ),
                customInputField1(
                  "Full Name",
                  Icons.person,
                  nameController,
                  validateName,
                ),

                customInputField1(
                  "Your Email",
                  Icons.email,
                  emailController,
                  validateName,
                ),

                _passwordRoundedField(
                    "Password", passwordController, validatePassword),
                _passwordRoundedField(
                    "Confirm Password", confirmController, validatePassword),

                //TODO: here we have to add sign up method on gesturedetector
                GestureDetector(
                  onTap: () async {
                    if (_signUpFormKey.currentState.validate()) {
                      print("Method called");
                      await context.read<AuthMethods>().signUp(
                        context: context,
                          fullname: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());

                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User user) {
                        if (user != null) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        } else {
                          return Center(
                            child: Text("failed to login"),
                          );
                        }
                      });
                    }
                  },
                  child: RoundedButton(
                    text: "SIGN UP",
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                //TODO: google authentication for sign up goes here
                GestureDetector(
                  onTap: () {
                    var signup = context.read<AuthMethods>();
                    signup.signUpwithGoogle(context);
                  },
                  child: _googleWidget(
                    "assets/icons/google.svg",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleWidget(String iconSrc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(7.5),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(
          width: 2,
          color: kPrimaryLightColor,
        ),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        iconSrc,
        height: 40,
        width: 40,
      ),
    );
  }

  Widget _passwordRoundedField(String title, TextEditingController mycontroller,
      FormFieldValidator<String> validator) {
// provider
    var visibility = context.watch<UpdateDataProvider>();
    Icon myIcon = visibility.isVisible
        ? Icon(
            Icons.visibility,
            color: kPrimaryColor,
          )
        : Icon(
            Icons.visibility_off,
            color: kPrimaryColor,
          );
    return TextFieldContainer(
      child: TextFormField(
        obscureText: visibility.isVisible,
        cursorColor: kPrimaryColor,
        validator: validator,
        controller: mycontroller,
        decoration: InputDecoration(
          hintText: title,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              //provider method which will change the true to false;
              print("ontap method called");
              visibility.changeVisibility();
            },
            child: myIcon,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }


}
