import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/bottomNavBar/sign.dart';
import 'file:///F:/Flutter%20Tasks/flutter%20course/flutter_course/lib/screens/bottomNavBar/home_page.dart';
import 'file:///F:/Flutter%20Tasks/flutter%20course/flutter_course/lib/screens/bottomNavBar/search.dart';
import 'file:///F:/Flutter%20Tasks/flutter%20course/flutter_course/lib/screens/bottomNavBar/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String errorMessage=' ';

  List screens = [
    HomePage() , Search() , Account()
  ];
 int current =0;
  String email;
  // FirebaseUser users;
  FirebaseAuth auth  =  FirebaseAuth.instance;
  User user;



Future<void> getUserData() async{
 try{
   setState(() {
     user =auth.currentUser;
     email = user.email;
     // print(userData.uid);
     // print(userData.email);
   });
   errorMessage=' ';
 }on FirebaseAuthException catch(error){
   errorMessage = error.message;
 }


}

// checkUser()async{
//     SharedPreferences user = await SharedPreferences.getInstance();
//     setState(() {
//       email= user.getString('email');
//     });
//   }

  @override
  void initState() {
    super.initState();
    getUserData();
    // checkUser();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: ('Search')
          ),
          BottomNavigationBarItem(
              icon:  email == null ?  Icon(Icons.login) : Icon(Icons.account_circle) ,
              label: email == null ?  ('Sign in'):('Account')
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.black,size: 25.0),
        selectedLabelStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.normal),
        selectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(color: Colors.grey,size: 20.0),
        unselectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.normal),
        unselectedItemColor: Colors.grey ,
        currentIndex: current,
          onTap: (index){
          setState(() {
            current=index;
          });
    }
      ),
      body: screens[current],
    );
  }
}
