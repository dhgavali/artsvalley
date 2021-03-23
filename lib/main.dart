import 'dart:async';
import 'package:artsvalley/helper/sharedpref.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/views/home.dart';
import 'package:artsvalley/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SharedPrefsHelper sharedpref = new SharedPrefsHelper();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<String> userstatus = sharedpref.getUserStatus();
    return MultiProvider(
      providers: [
        Provider<AuthMethods>(
          create: (_) => AuthMethods(FirebaseAuth.instance, userstatus),
        ),
        StreamProvider(
          create: (context) => context.read<AuthMethods>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.amberAccent,
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Color(0xff212121)),
        home: AuthenticationWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    }
    return SignIn();
  }
}
