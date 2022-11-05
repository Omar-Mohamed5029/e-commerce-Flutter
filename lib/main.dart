import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/bottomNavBar/account.dart';
import 'package:flutter_course/screens/bottomNavBar/contact.dart';
import 'package:flutter_course/screens/bottomNavBar/home_page.dart';
import 'package:flutter_course/screens/bottomNavBar/search.dart';
import 'package:flutter_course/screens/details.dart';
import 'package:flutter_course/screens/drawer/about.dart';
import 'package:flutter_course/screens/drawer/sell.dart';
import 'package:flutter_course/screens/drawer/setting.dart';
import 'package:flutter_course/screens/drawer/shoppingcart.dart';
import 'package:flutter_course/screens/drawer/wishlist.dart';
import 'package:flutter_course/screens/result.dart';
import 'package:flutter_course/screens/bottomNavBar/sign.dart';
import 'package:flutter_course/screens/splashscreen.dart';
import 'package:flutter_course/widgets/searchmap.dart';

import 'screens/bottomNavBar/bottomnavbar.dart';
// void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreens(),
      routes: {
        'account' : (context) => Account(),
        'homepage' :  (context) => HomePage(),
        'search' :  (context) => Search() ,
        'about' :  (context) => About(),
        'contact' :  (context) => Contact(),
        'setting' :  (context) => Setting(),
        'shoppingcart' : (context) => ShoppingCart(),
        'wishlist' : (context) => WishList(),
        // 'result' : (context) => Result(),
        'signIn' : (context) => Sign(),
        'details':  (context) => Details(null,null,null),
        'searchmap':  (context) => SearchMap(),
        'sell':  (context) => Sell(),


      },
    );
  }
}
//AIzaSyC01I48ovGssG-cjkoQsCJ86b5PmmDHiXU


