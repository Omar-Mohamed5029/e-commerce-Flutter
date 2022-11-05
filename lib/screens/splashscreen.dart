import 'package:flutter/material.dart';
import 'package:flutter_course/screens/bottomNavBar/bottomnavbar.dart';
import 'package:flutter_course/screens/bottomNavBar/sign.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreens extends StatefulWidget {
  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SplashScreen(
        seconds: 4,
        backgroundColor: Colors.grey[100],
        image: Image.asset('assets/images/omar.jpeg') ,
        loaderColor: Colors.black,
        navigateAfterSeconds: BottomNavBar(),
        // navigateAfterSeconds: email == null ?  Sign() : BottomNavBar(),
      ),
    );
  }
}
