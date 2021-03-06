import 'dart:async';
import 'package:artsvalley/providers/loading_provider.dart';
import 'package:artsvalley/views/btm_animated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthMethods {
  final FirebaseAuth _auth;
  UserCredential user;
  AuthMethods(this._auth);
  Stream<User> get authStateChanges => _auth.idTokenChanges();

//Sign in method no need to add data.
  // Future<UserCredential> signInWithGoogle() async {
  Future<void> signInWithGoogle() async {
    //first trigger authentication
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    //obtain the auth details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    //create a new credentials
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    //saving the user data to shared preferences

    // // sign in method
    final _username =
        googleUser.email.replaceAll(RegExp(r'@(\w*)\.(\w*)'), "").trim();
    try {
      UserCredential firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (firebaseUser != null) {
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('userid', isEqualTo: firebaseUser.user.uid)
            .get();
        final List<DocumentSnapshot> documents = result.docs;
        if (documents.length == 0) {
          // Update data to server if new user
          FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.user.uid)
              .set(
            {
              'username': _username,
              'useremail': firebaseUser.user.email,
              'displayname': firebaseUser.user.displayName,
              'photoUrl': firebaseUser.user.photoURL,
              'userid': firebaseUser.user.uid,
              'followerList': {},
              'address': '',
              'gender': '',
              'mobileNumber': '',
              'privacy': "Everyone",
            },
            SetOptions(merge: true),
          );
        }
      }
      return firebaseUser;
    } catch (error) {
      print(error);
    }
  }

//sign in with email and password

  Future<void> signIn(
      {BuildContext context, String email, String password}) async {
    //creating a provider

    try {
      UserCredential _user = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user != null) {
          Provider.of<LoadingProvider>(context, listen: false).loadPage(false);
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
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      switch (e.code) {
        case "wrong-password":
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email Already in Use")));
          break;
        case "user-not-found":
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Account Does not Exists")));
          break;
      }
    }
  }

  Future<void> signUp(
      {BuildContext context,
      String fullname,
      String email,
      String password}) async {
    final _username = email.replaceAll(RegExp(r'@(\w*)\.(\w*)'), "").trim();

    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      Map<String, dynamic> _userdata = {
        'username': _username,
        'useremail': email.trim(),
        'displayname': fullname.trim(),
        'photoUrl': user.user.photoURL,
        'userid': user.user.uid,
        'followerList': {},
        'address': '',
        'gender': '',
        'mobileNumber': '',
        'privacy': "Everyone",
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.user.uid)
          .set(_userdata);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email Already in Use")));
    }
  }

// Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
}
