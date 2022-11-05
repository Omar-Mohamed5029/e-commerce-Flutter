import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../bottomNavBar/bottomnavbar.dart';

class Sell extends StatefulWidget {
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  final TextEditingController ProductNameController = TextEditingController();
  final TextEditingController ProductDescriptionController =
      TextEditingController();
  final TextEditingController ProductPriceController = TextEditingController();
  File image;
  String url = 'omar';
  String email;
  String id;
  bool isLoading = false;
  String errorMessage = '';
  CollectionReference data;
  DatabaseReference deRef;
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;

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

  Future<void> userdata() async {
    data = FirebaseFirestore.instance.collection('products');

    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Shopping cart',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            InkWell(
              child: Container(
                margin: EdgeInsets.only(
                    top: 0.0, bottom: 10.0, right: 10.0, left: 10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: image != null
                          ? FileImage(image)
                          : AssetImage('assets/images/addimage.PNG'),
                      fit: BoxFit.fitHeight,
                    )),
                alignment: Alignment.bottomRight,
                child: image == null
                    ? IconButton(
                        icon: Icon(Icons.add_a_photo),
                        color: Colors.black,
                        iconSize: 20.0,
                        onPressed: () {
                          getimage();
                        },
                      )
                    : null,
              ),
              onTap: () {
                getimage();
              },
            ),
            field('Product Name', ProductNameController, TextInputType.text),
            field('Product Description', ProductDescriptionController,
                TextInputType.text),
            field(
                'Product Price', ProductPriceController, TextInputType.number),
            isLoading
                ? Center(
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
                  )
                : TextButton(
                    onPressed: () {
                      if (ProductNameController != null ||
                          ProductDescriptionController.text != null ||
                          ProductPriceController != null) {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          errorMessage = '';
                          setState(() {
                            uploadImage();
                            getUserData();
                            userdata();
                            data.add({
                              'date': DateFormat('yyyy-MM-dd KK:mm a')
                                  .format(DateTime.now()),
                              'email': email,
                              'id': id,
                              'image': url,
                              'phone': 011,
                              'descriptoin': ProductDescriptionController.text,
                              'price': int.parse(ProductPriceController.text)
                              // 'username': 'omar'
                            });
                          });
                          setState(() {
                            isLoading = false;
                          });
                        } on FirebaseAuthException catch (error) {
                          errorMessage = error.message;
                        }
                        setState(() {});

                        // SharedPreferences user = await SharedPreferences.getInstance();
                        // user.setString('email', emailcontroller.text);

                        if (errorMessage == '') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                            (Route<dynamic> route) => false,
                          );
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
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0)))
                                // borderRadius:BorderRadius.all(Radius.circular(15.0)
                                ));
                      }
                    },
                    child: Text(
                      'Sell',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ))
          ],
        ),
      ),
    );
  }

  field(String label, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
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
          labelText: label,
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
          suffixIcon: label == 'password'
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.black,
                  iconSize: 20.0,
                  onPressed: () {
                    setState(() {
                      // obsecure =!obsecure;
                    });
                  },
                )
              : null,
        ),
        keyboardType: type,
        textInputAction: TextInputAction.done,
        controller: controller,
        // obscureText: label == 'email'? false : obsecure,
      ),
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        )),
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              color: Colors.grey[100],
            ),
            child: Column(
              children: [
                Text(
                  'Choose Destination',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                ListTile(
                    title: Text(
                      'Camera',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                    leading: Icon(
                      Icons.camera,
                      color: Colors.grey,
                      size: 15.0,
                    )),
                ListTile(
                    title: Text(
                      'Gallery',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      pickImage(ImageSource.gallery);
                    },
                    leading: Icon(
                      Icons.photo_album,
                      color: Colors.grey,
                      size: 15.0,
                    ))
              ],
            ),
          );
        });
  }

  uploadImage() async {
    FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://furniture-edb22.appspot.com');
    StorageReference ref = storage.ref().child(p.basename(image.path));
    StorageUploadTask storageUploadTask = ref.putFile(image);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String _url = await taskSnapshot.ref.getDownloadURL();
    url = await _url;
    setState(() {});
  }
}
