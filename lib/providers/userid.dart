import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser {
  final String userid = FirebaseAuth.instance.currentUser.uid;
  get myUserid => this.userid;
}
