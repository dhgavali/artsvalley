import 'package:artsvalley/components/already_have_an_account_acheck.dart';
import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/components/text_field_container.dart';
import 'package:artsvalley/providers/loading_provider.dart';
import 'package:artsvalley/views/btm_animated.dart';
import 'package:artsvalley/views/loginscreens/Signup/signup_screen.dart';
import 'package:artsvalley/providers/visibilityprovider.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/loginscreens/reset/resetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  final GlobalKey<FormState> _signinkey = GlobalKey<FormState>();

  
  String validateName(value) {
    var name = usernameController.text;

    if (name.isEmpty) {
      return "* username can't be empty";
    }
    return null;
  }

  String validatePassword(value) {
    var pass = pwdController.text;
    if (pass.isEmpty) {
      return "* Please enter a password";
    } else if (pass.length < 6) {
      return "* Paswword should be atleast 6 characters ";
    } else if (pass.length > 15) {
      return "* Password should not be greater than 15 characters";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _signinkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<LoadingProvider>(
                  builder: (context, value, child) {
                    return value.isLoaded
                        ? LinearProgressIndicator(
                            minHeight: 5,
                          )
                        : Container(height: 5);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  width: size.width * 0.80,
                  child: Image(
                    image: AssetImage('assets/images/splash1.png'),
                  ),
                ),
                customInputField1(
                  "Username",
                  Icons.email,
                  usernameController,
                  validateName,
                ),
                _passwordRoundedField(
                  "Password",
                  pwdController,
                  validatePassword,
                ),
                SizedBox(height: 10),
                Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    widthFactor: 2.5,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ResetPassword(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_signinkey.currentState.validate()) {
                      Provider.of<LoadingProvider>(context, listen: false)
                          .loadPage(true);
                      await context.read<AuthMethods>().signIn(
                            context: context,
                            email: usernameController.text.trim(),
                            password: pwdController.text.trim(),
                          );
                 
                    }
                  },
                  child: RoundedButton(
                    text: "LOGIN",
                    color: kPrimaryColor,
                  ),
                ),

                //google login button
                GestureDetector(
                  onTap: () async {
                    await context.read<AuthMethods>().signInWithGoogle();

                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User user) {
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DesignBTMMyHomePage(),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text("failed to login"),
                        );
                      }
                    });
                  },
                  child: RoundedButton(
                    text: "Continue with google",
                    color: kteagreen2,
                    textColor: kerichblack,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordRoundedField(String title, TextEditingController mycontroller,
      FormFieldValidator<String> validator) {
// provider
    var visibility = context.watch<VisibilityProvider>();
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
      bgcolor: kcream,
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
