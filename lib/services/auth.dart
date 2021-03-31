import 'dart:async';

import 'package:artsvalley/helper/sharedpref.dart';
import 'package:artsvalley/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth;
  final userstatus;
  AuthMethods(this._auth, this.userstatus);

  Stream<User> get authStateChanges => _auth.idTokenChanges();

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

    Map<String, String> data = {
      "username": googleUser.email.replaceAll("@gmail.com", "").trim(),
      "useremail": googleUser.email,
      "displayname": googleUser.displayName,
      "photourl": googleUser.photoUrl,
      'userid': googleUser.id,
    };
    DataMethods db = new DataMethods();
    db.addUserRecord(data);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//sign in with email and password

  Future<void> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("Signed in");
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<void> signUp({String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Signed Up");
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
