import 'dart:async';
import 'package:artsvalley/helper/sizeconfig.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/providers/loading_provider.dart';
import 'package:artsvalley/providers/visibilityprovider.dart';
import 'package:artsvalley/routes.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/services/connectivityService.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/btm_animated.dart';
import 'package:artsvalley/views/loginscreens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'enum/connectivityStatus.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthMethods>(
          create: (context) => AuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              Provider.of<AuthMethods>(context, listen: false).authStateChanges,
        ),
        ChangeNotifierProvider(create: (context) => VisibilityProvider()),
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => UploadPost()),
        ChangeNotifierProvider(create: (context) => EditProfile()),
      ],
      child: StreamProvider<ConnectivityStatus>(
        initialData: null,
        create: (_) =>
            ConnectivityService().connectivityStatusController.stream,
        child: MaterialApp(
          title: "Arts Valley",
          routes: routes,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: kPrimaryColorDark,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(color: Colors.black),
            ),
            primaryColorDark: kPrimaryColorDark,
            primaryColor: kPrimaryColor,
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            backgroundColor: Color(0xfff1f1f1),
            primaryTextTheme: TextTheme(
              headline6: TextStyle(color: Colors.black),
            ),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 28.00,
                fontWeight: FontWeight.bold,
              ),
              headline2: TextStyle(
                fontSize: 26.00,
                fontWeight: FontWeight.bold,
              ),
              bodyText1: TextStyle(
                fontSize: 20.00,
              ),
            ),
          ),
          home: AnimatedSplashScreen(
            splash: Image.asset('assets/images/logo.png'),
            nextScreen: AuthenticationWrapper(),
            splashIconSize: 200,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
            duration: 3000,
          ),
          // home: AuthenticationWrapper(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final firebaseUser = Provider.of<User>(context);

    if (firebaseUser != null) {
      return DesignBTMMyHomePage();
    }
    return WelcomeScreen();
  }
}
