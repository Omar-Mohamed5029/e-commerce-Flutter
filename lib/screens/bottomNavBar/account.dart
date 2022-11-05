import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/bottomNavBar/bottomnavbar.dart';
import 'package:flutter_course/screens/bottomNavBar/sign.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
File image;
String email;
FirebaseAuth auth  =  FirebaseAuth.instance;
User user;
String errorMessage=' ';



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
//   SharedPreferences user = await SharedPreferences.getInstance();
//   setState(() {
//     email= user.getString('email');
//   });
// }
@override
void initState() {
  // TODO: implement initState
  super.initState();
  Firebase.initializeApp().whenComplete(() {
    print("completed");
    // deRef = FirebaseDatabase.instance.reference().child('users');
    setState(() {});
  });


  getUserData();
  // checkUser();
}

  @override
  Widget build(BuildContext context) {
    return email==null? Sign():Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 20.0
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'My Account',
          style: TextStyle(color: Colors.black,
              fontSize: 20.0,fontWeight: FontWeight.bold,),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.0,bottom: 10.0,right: 10.0,left: 10.0),
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/4,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: image != null? FileImage(image) : AssetImage('assets/images/omar.jpeg'),
                          fit: BoxFit.fitHeight,
                        )
                    ),
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Colors.black,
                      iconSize: 20.0,
                      onPressed: (){
                        showModalBottomSheet(
                            context: context,
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(15.0),topRight:Radius.circular(15.0),)),
                          builder: (BuildContext context){
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft:Radius.circular(15.0),topRight:Radius.circular(15.0),),
                                  color: Colors.grey[100],

                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Choose Destination',
                                      style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                                    ),
                                    ListTile(
                                      title: Text(
                                        'Camera',
                                        style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                                      ),
                                      onTap: (){
                                        pickImage(ImageSource.camera);
                                      },

                                      leading:Icon(Icons.camera,color: Colors.grey,size: 15.0,)
                                    ),
                                    ListTile(
                                        title: Text(
                                          'Gallery',
                                          style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                                        ),
                                        onTap: (){
                                          pickImage(ImageSource.gallery);
                                        },
                                        leading:Icon(Icons.photo_album,color: Colors.grey,size: 15.0,)
                                    )
                                  ],
                                ),
                              );

                          }
                        );
                      },
                    ),
                  ),
                  item('email',  email, Icons.email),
                Center(
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),),
                ),
                  item('password', '*********', Icons.lock),
                  item('Gende', 'Male', Icons.person),
                  item('Birth Day', '20 - May - 1998', Icons.perm_contact_calendar),
                  TextButton(

                    onPressed: () async {

                      // SharedPreferences user = await SharedPreferences.getInstance();
                      // setState(() {
                      //    user.clear();
                      // });
                      try{
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                        });
                        errorMessage=' ';
                      }on FirebaseAuthException catch(error){
                        errorMessage = error.message;
                      }

                      // exit(0);
                      Navigator.push(context,MaterialPageRoute(builder: (_){return BottomNavBar();}) );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      'Sign out',
                      style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    ),

                  )


                ],

            )
          ],


        ),
      ),
    );
  }
  item(String title, String subtitle,IconData icon){
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.black,
            fontSize: 20.0,fontWeight: FontWeight.bold,
        ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.black,
            fontSize: 20.0,fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(icon, color: Colors.grey,size: 20.0,),
      ),
    );
  }
  pickImage(ImageSource imageSource) async {
    var _image = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      image = _image ;
    });
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String base64Image = base64Encode(image);
    // prefs.setString("image", base64Image);

    // user.set
  }
static Future<bool> saveImage(List<int> imageBytes) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String base64Image = base64Encode(imageBytes);
  return prefs.setString("image", base64Image);
}

static Future<Image> getImage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Uint8List bytes = base64Decode(prefs.getString("image"));
  return Image.memory(bytes);
}
}
