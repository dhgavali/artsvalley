import 'dart:async';

import 'package:artsvalley/helper/sharedpref.dart';
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
             