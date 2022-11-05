import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/googleauth.dart';
import 'package:flutter_course/screens/bottomNavBar/bottomnavbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p ;

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> with TickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2,initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black,size: 20.0),
      elevation: 0.0,
      title: Text(
        'Welcome!',
        style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
      ),
    bottom: PreferredSize(
      preferredSize: Size(0.0,40.0),
      child: TabBar(
        controller: tabController,

        tabs: [
          Text('Sign In') , Text('Register')
        ],
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.transparent,
          border:Border.all(color: Colors.black),
          shape: BoxShape.rectangle
        ),
        labelColor: Colors.black,
        labelStyle: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold),
      ),
    ),
      ),
    backgroundColor: Colors.grey[100],
    body: Container(
    margin: EdgeInsets.all(10.0),
      child: TabBarView(
        controller: tabController,
        children: [
          SignIn(),Register()
        ],
      ),
    ),

    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController emailDialogcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool obsecure = true;
  final _formKey=GlobalKey<FormState>();
  bool is_valid=false;
  bool isLoading=false;
  String errorMessage = '';
  static final GlobalKey<FormFieldState<String>> emailKey= GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> passwordKey= GlobalKey<FormFieldState<String>>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form (
        key: _formKey ,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 15.0),
            field('email', Icons.email, emailcontroller, TextInputType.emailAddress,emailKey,validateEmail),

            SizedBox(height: 15.0),
            field('password', Icons.lock, passwordcontroller, TextInputType.emailAddress,passwordKey,validatePassword),

            SizedBox(height: 15.0),
            Center(
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(

                child: Text(
                  'Forget Password?!',
                  style: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),
                ),
                onTap: (){
                   showDialog(
                     context: context,
                     // barrierDismissible: false,
                     builder: (BuildContext context){
                       return AlertDialog(
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)) ,
                         title: Text(
                           'Forget Password',
                           style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),
                         ),
                         actions: [
                           TextButton(
                               onPressed: (){
                               },
                               child: Text(
                                 'send',
                                 style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),
                               ),
                               style: TextButton.styleFrom(primary: Colors.black,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                               )
                           ),
                           TextButton(
                             onPressed: (){
                                Navigator.pop(context);
                           },
                             child: Text(
                               'cancel',
                               style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),
                             ),
                               style: TextButton.styleFrom(primary: Colors.black,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                               )

                           ),
                         ],
                         content: field('Type email', Icons.email, emailDialogcontroller, TextInputType.emailAddress, null,validatePassword),
                       );
                     }
                   );
                },
              ),
            ),
            isLoading ?  Center(
              heightFactor: 1,
              widthFactor: 1,
              child: Container(
                margin: EdgeInsets.all(10),
                child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
              ),
            ):TextButton(
              onPressed: () async {
                if(_formKey.currentState.validate()){

                    try {
                     setState(() {
                       isLoading=true;
                     });
                       await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: emailcontroller.text,
                        password: passwordcontroller.text,
                      );
                       errorMessage = '';
                       setState(() {
                         isLoading=false;
                       });
                    } on FirebaseAuthException catch (error) {
                      errorMessage = error.message;
                    }

                    if(errorMessage == '') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
                            (Route<dynamic> route) => false,);
                    }

                }else{
                  return ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.blue,
                      duration: Duration(seconds: 5),
                      content: Text(
                        'some fields required',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15.0),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)))
                        // borderRadius:BorderRadius.all(Radius.circular(15.0)
                  )
                  );
                }
              },
              child: Text(
                'Sign in',
                style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
                style: TextButton.styleFrom(backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                )
            ),
            TextButton(
              onPressed: () async {
                signInWithGoogle().whenComplete(() =>
                    Navigator.push(context,MaterialPageRoute(builder: (_){return BottomNavBar();}) )
                );
              },
              child: Text(
                'Google',
                style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),
              ),
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                )
            )
          ],
        ),
      )


      );
  }

  field(String label, IconData icon , TextEditingController controller, TextInputType type,Key key,Function validator){
    return TextFormField(
      key: label == 'Type email' ? null : key,
      validator: validator,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black,width: 0.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.grey,width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black,width: 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red,width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black,width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.black,width: 0.5),
        ),
        prefixIcon: Icon(icon,color:Colors.black,size: 20.0,),
        labelText: label,
        labelStyle: TextStyle(color:Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),
        suffixIcon:label=='password' ? IconButton(
          icon: Icon(Icons.remove_red_eye),
          color: Colors.black,
          iconSize: 20.0,
          onPressed: (){
            setState(() {
              obsecure =!obsecure;
            });
          },
      ):null,
      ),
      keyboardType: type,
      textInputAction: TextInputAction.done,
      controller: controller,
      obscureText: label == 'email'? false : obsecure,
    );

  }
  String validateEmail(String formEmail){
    if(formEmail == null || formEmail.isEmpty)
      return 'E-mail address isreqired';

    String pattern = r'\w+@\w+.\w+';
    RegExp regex =RegExp(pattern);
    if(!regex.hasMatch(formEmail))
      return 'Invalid email address format';

    return null;
  }
  String validatePassword(String formPassword){
    if(formPassword == null || formPassword.isEmpty)
      return 'password address is reqired';

    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(formPassword))
    //   return '''
    //   Password must be at least 8 characters,
    //   include an uppercase letter, number and symbol.
    //   ''';
    //
    // return null;
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController emailDialogcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool obsecure = true;
  final _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> emailKey = GlobalKey<
      FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> passwordKey = GlobalKey<
      FormFieldState<String>>();
  String gender = 'None';
  bool checked = false;
  String pickedDate;
  File image;
  bool isLoading= false;
  String url=" ";
  String id='omr';
  String errorMessage = '';
  DatabaseReference deRef;
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  String email;
  CollectionReference data;

  Future<void> getUserData() async {
    try {
      setState(() {
        user = auth.currentUser;
        email = user.email;
        id = user.uid;

      });
      errorMessage = '';
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message;
    }
  }
    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      Firebase.initializeApp().whenComplete(() {
        print("completed");
        // deRef = FirebaseDatabase.instance.reference().child('users');
        setState(() {});
      });
    }
    Future<void> userdata() async {
       data = FirebaseFirestore.instance.collection('users');

      return;
    }
    @override
    Widget build(BuildContext context) {
      return
        Container(

            child: Form(
              key: _formKey,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [InkWell(
                  child: Container(

                    margin: EdgeInsets.only(top: 0.0, bottom: 10.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: image != null ? FileImage(image) : AssetImage(
                              'assets/images/addimage.PNG'),
                          fit: BoxFit.fitHeight,
                        )
                    ),
                    alignment: Alignment.bottomRight,
                    child: image == null ? IconButton(
                      icon: Icon(Icons.add_a_photo),
                      color: Colors.black,
                      iconSize: 20.0,
                      onPressed: () {
                        getimage();
                        setState(() {});
                      },
                    ) : null,


                  ),
                  onTap: () {
                    getimage();
                  },
                ),
                  SizedBox(height: 15.0),
                  field('email', Icons.email, emailcontroller, TextInputType.emailAddress, emailKey, validateEmail),
                  SizedBox(height: 15.0),
                  field('password', Icons.lock, passwordcontroller,
                      TextInputType.emailAddress, passwordKey,
                      validatePassword),
                  SizedBox(height: 15.0),
                  Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white
                    ),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ListTile(
                      title: Text(
                        'Gender',
                        style: TextStyle(color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        gender,
                        style: TextStyle(color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        icon: Icon(Icons.arrow_downward, color: Colors.black,
                          size: 20.0,),
                        itemBuilder: (BuildContext contex) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem(
                              child: Text(
                                'Male',
                                style: TextStyle(color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ), value: 'Male',),
                            PopupMenuItem(
                              child: Text(
                                'Female',
                                style: TextStyle(color: Colors.black,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ), value: 'Female',),
                          ];
                        },
                        onSelected: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white
                    ),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ListTile(
                      title: Text(
                        'Accept Conditions',
                        style: TextStyle(color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Read Terms & condition',
                        style: TextStyle(color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: checked,
                        onChanged: (value) {
                          setState(() {
                            checked = value;
                          });
                        },
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            builder: (BuildContext context) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    10.0, 5.0, 10.0, 0.0),
                                child: ListTile(
                                  title: Text(
                                    'Read Terms & condition',
                                    style: TextStyle(color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Read Terms & condition \nRead Terms & condition \nRead Terms & condition \nRead Terms & condition \nRead Terms & condition',
                                    style: TextStyle(color: Colors.grey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white
                    ),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ListTile(
                      title: Text(
                        'Date of Birth',
                        style: TextStyle(color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${pickedDate.toString()}',
                        style: TextStyle(color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),

                      onTap: () async {
                        var picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980),
                          lastDate: DateTime.now(),
                        );
                        setState(() {
                          pickedDate = picked.toString().substring(0, 10);
                        });
                      },

                    ),
                  ),isLoading?Center(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                  ):
                  TextButton(
                    onPressed: () async {
                      // Navigator.push(context,MaterialPageRoute(builder: (_){return BottomNavBar();}) );
                      if (_formKey.currentState.validate()) {
                        try {
                          setState(() {
                            isLoading =true;
                          });
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: emailcontroller.text,
                              password: passwordcontroller.text);
                          errorMessage = '';
                          setState(() {
                            uploadImage();
                            getUserData();
                            userdata();
                            data.add({
                              'date': pickedDate,
                              'email': email,
                              'gender': gender,
                              'id': id,
                              'image': url,
                              'phone': 011,
                              // 'username': 'omar'
                            });
                          });
                        }
                        on FirebaseAuthException catch (error) {
                          errorMessage = error.message;
                        }
                        setState(() {
                              isLoading = false;
                        });

                        if (errorMessage == '') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                                (Route<dynamic> route) => false,);
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        // print(res);

                      } else {
                        return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.blue,
                                duration: Duration(seconds: 5),
                                content: Text(
                                  'some fields required',
                                  style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)))
                              // borderRadius:BorderRadius.all(Radius.circular(15.0)
                            )
                        );
                      }
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),

                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.0))),
                    ),


                  )

                ],
              ),
            )


        );
    }
    field(String label, IconData icon, TextEditingController controller,
        TextInputType type, Key key, Function validate) {
      return TextFormField(
        key: label == 'Type email' ? null : key,
        validator: validate,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          prefixIcon: Icon(icon, color: Colors.black, size: 20.0,),
          labelText: label,
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
          suffixIcon: label == 'password' ? IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Colors.black,
            iconSize: 20.0,
            onPressed: () {
              setState(() {
                obsecure = !obsecure;
              });
            },
          ) : null,
        ),
        keyboardType: type,
        textInputAction: TextInputAction.done,
        controller: controller,
        obscureText: label == 'email' ? false : obsecure,
      );
    }
    pickImage(ImageSource imageSource) async {
      var _image = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        image = _image as File;
      });
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // String base64Image = base64Encode(image);
      // prefs.setString("image", base64Image);

      // user.set
    }
    getimage() {
      return showModalBottomSheet(
          context: context,
          backgroundColor: Colors.grey[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),)),
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),),
                color: Colors.grey[100],

              ),
              child: Column(
                children: [
                  Text(
                    'Choose Destination',
                    style: TextStyle(color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                      title: Text(
                        'Camera',
                        style: TextStyle(color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        pickImage(ImageSource.camera);
                      },

                      leading: Icon(
                        Icons.camera, color: Colors.grey, size: 15.0,)
                  ),
                  ListTile(
                      title: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      leading: Icon(
                        Icons.photo_album, color: Colors.grey, size: 15.0,)
                  )
                ],
              ),
            );
          }
      );
    }
    uploadImage() async {
      FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://furniture-edb22.appspot.com');
      StorageReference ref = storage.ref().child(p.basename(image.path));
      StorageUploadTask storageUploadTask = ref.putFile(image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      String _url = await taskSnapshot.ref.getDownloadURL();
      url=await _url;
      setState(() {});
    }
    String validateEmail(String formEmail) {
      if (formEmail == null || formEmail.isEmpty)
        return 'E-mail address isreqired';

      String pattern = r'\w+@\w+.\w+';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(formEmail))
        return 'Invalid email address format';

      return null;
    }
    String validatePassword(String formPassword) {
      if (formPassword == null || formPassword.isEmpty)
        return 'password address is reqired';

      // String pattern =
      //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      // RegExp regex = RegExp(pattern);
      // if (!regex.hasMatch(formPassword))
      //   return '''
      //   Password must be at least 8 characters,
      //   include an uppercase letter, number and symbol.
      //   ''';
      //
      // return null;
    }
  }



