import 'dart:async';
import 'package:artsvalley/helper/sharedpref.dart';
import 'package:artsvalley/loginscreens/Login/login_screen.dart';
import 'package:artsvalley/providers/user.dart';
import 'package:artsvalley/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth;
  final userstatus;
  AuthMethods(this._auth, this.userstatus);
  DataMethods db = new DataMethods();
  // final FirebaseFirestore _dbconn = FirebaseFirestore.instance;

  Stream<User> get authStateChanges => _auth.idTokenChanges();

//Sign in method no need to add data.
  Future<UserCredential> signInWithGoogle() async {
    //first trigger authentication
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    //obtain the auth details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    //create a new credentials
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    //saving the user data to shared preferences
    SharedPrefsHelper sharedpref = new SharedPrefsHelper();
    sharedpref.saveUserEmail(googleUser.email);
    sharedpref.saveUserName(googleUser.email.replaceAll("@gmail.com", ""));
    sharedpref.saveDisplayName(googleUser.displayName);
    sharedpref.saveUserPhotoUrl(googleUser.photoUrl);
    sharedpref.isUserLoggedIn("true");
    sharedpref.saveUserId(googleUser.id);
    FirebaseUser(uid: googleUser.id);
    // sign in method
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//sign in with email and password

  Future<void> signIn({String email, String password}) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Map<String, dynamic> data = await db.getUserData(email.trim());
      // Future<QuerySnapshot> data = await db.getUserData(email);
      SharedPrefsHelper _sharedpref = new SharedPrefsHelper();
      final _username = email.replaceAll(RegExp(r'@(\w*)\.(\w*)'), "").trim();
      // sharedpref.saveUserName(data.email);
      _sharedpref.saveUserEmail(user.user.email);
      _sharedpref.saveUserName(_username);
      _sharedpref.saveDisplayName(user.user.displayName);
      _sharedpref.saveUserPhotoUrl(null);
      // sharedpref.isUserLoggedIn("true");
      _sharedpref.saveUserId(user.user.uid);
      FirebaseUser(uid: user.user.uid);
    } on FirebaseAuthException catch (e) {
      print(e.message);

      // return LoginErrorPage();
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<void> signUp(
      {BuildContext context,
      String fullname,
      String email,
      String password}) async {
    final _username = email.replaceAll(RegExp(r'@(\w*)\.(\w*)'), "").trim();
    LinearProgressIndicator();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((snapshot) {
        Map _userdata = {
          'username': _username,
          'useremail': email.trim(),
          'displayname': fullname.trim(),
          'photoUrl': null,
          'userid': null,
        };
        db.addUserRecord(_userdata, snapshot).then((value) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        });
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email Already In Use")));
    }
  }

  //Sign Up With Google
  signUpwithGoogle(BuildContext context) async {
    print("sign up method called properly");
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    //obtain the auth details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    //create a new credentials
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      print("try block started");
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      Map userdata = {
        'username': user.user.email.replaceAll("@gmail.com", ""),
        'useremail': user.user.email,
        'displayname': user.user.displayName,
        'photoUrl': user.user.photoURL,
        'userid': user.user.uid,
      };

      //checking whether user is already reigstered or not
      final CollectionReference _dbconn =
          FirebaseFirestore.instance.collection("users");

      _dbconn
          .where("useremail", isEqualTo: user.user.email)
          .get()
          .then((snapshot) {
        print("fetch method started");
        if (snapshot.docs.isEmpty) {
          print("snapshot is empty");
          db.addUserRecord(userdata, user).then((snapshot) {
            if (snapshot == null) {
              print("failed to add record");
              print("failed to add record");
              print("failed to add record");
            } else {
              print("snapshot is not empty but navigator is not called");
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            }
          });
        } else {
          print("snapshot has data user already registered");
          print("length is ${snapshot.docs.length}");
          print("data is ${snapshot.docs.first.exists}");
          print("data is ${snapshot.docs.first.id}");
        }
      });
    } on FirebaseAuthException catch (signUpError) {
      if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        print("email is already in use");
      }
    } catch (e) {
      print("catch block started");
    }

    print("at the end of the sign up method");
  }

// try {
//   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: "barry.allen@example.com",
//     password: "SuperSecretPassword!"
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'weak-password') {
//     print('The password provided is too weak.');
//   } else if (e.code == 'email-already-in-use') {
//     print('The account already exists for that email.');
//   }
// } catch (e) {
//   print(e);

//sign in
//try {
//   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: "barry.allen@example.com",
//     password: "SuperSecretPassword!"
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
// }

}
