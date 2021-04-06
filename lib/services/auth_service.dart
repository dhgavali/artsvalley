import 'dart:async';

import 'package:artsvalley/models/user.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AuthService with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FirebaseUser _userFromFirebaseUser(User user){
  //   return user != null ? FirebaseUser(uid: user.uid) : null;
  // }

  // Stream<FirebaseUser> get user {
  //   return _auth.authStateChanges().map(_userFromFirebaseUser);
  // }

  //sign in with email and password 

  Future signInWithEmailAndPassword(String email, String password, ) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;  
    }on FirebaseAuthException catch(e){
      print(e.toString());
      notifyListeners();
      
    }
    
  }
  
  // register with email and password 
  Future registerWithEmailAndPassword(String email, String password , String controller ) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //creating document by calling method from databse service 

      await DatabaseService(uid: user.uid).updateUserData(user.email.replaceAll("@gmail.com", "").trim(), controller.trim(), user.email, null);

      // return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  

  Future signout() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  notifyListeners();


}
