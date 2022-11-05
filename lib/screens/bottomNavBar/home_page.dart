import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/screens/bottomNavBar/contact.dart';
import 'package:flutter_course/screens/details.dart';
import 'package:flutter_course/screens/drawer/about.dart';
import 'package:flutter_course/screens/drawer/setting.dart';
import 'package:flutter_course/screens/drawer/shoppingcart.dart';
import 'package:flutter_course/screens/drawer/wishlist.dart';
import 'package:flutter_course/screens/result.dart';

import '../../widgets/item.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> drawerItemTitle=[
    'Wish List','Shopping Cart','Sell ','Setting','Contact us' , 'About us'
  ];
  List<String> drawerItemSubTitle=[
    'see your favourite items','Buy Now','Earn your money','Edit Your Account Data' , 'need help.?','know more about us'
  ];
  List<IconData> drawerItemIcon=[
    Icons.favorite , Icons.shopping_cart,Icons.add,Icons.settings,Icons.phone,Icons.info_outline
  ];
  List itemphoto =[
    'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
  ];
  // List drawerscreens=[
  //   WishList() , ShoppingCart() , Setting(), Contact() ,About()
  // ];
  List drawerscreens = [
    'wishlist', 'shoppingcart' ,'sell', 'setting' , 'contact', 'about'
  ];
  List itemname =[
    'yellow chiar','white chair','red chair','gery chair','gery sofa',
  ];
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture:false,
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Welcome',
              style: TextStyle(
            color: Colors.black
        ),
        ),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black,size: 20.0 ),
      // leading: Icon(
      //   Icons.more_horiz,
      //   color: Colors.black,
      //   size: 20.0,
      // ),
      actions: <Widget>[
        Icon(
          Icons.shopping_basket,
          color:Colors.black,
          size: 25.0,

        ),
      ],
      ),
    backgroundColor: Colors.grey[100],
    drawer: Drawer(
    child:Container(
      color: Colors.grey[100],
    child: ListView.builder(

    scrollDirection: Axis.vertical,
    itemCount: drawerItemTitle.length,

    itemBuilder:(context,index){
      return Container(

      margin: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15.0)
    ),
    child: ListTile(
    leading: Icon(
    drawerItemIcon[index],
    color: Colors.black,
    size: 20.0,
    ),
    trailing: Icon(
    Icons.navigate_next,
    color: Colors.black,
    size: 20.0,
    ),
    title: Text(
    drawerItemTitle[index],
    style: TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.normal
    ),
    ),
      subtitle: Text(
    drawerItemSubTitle[index],
      style: TextStyle(
      color: Colors.grey,
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
    ),
      ),
      onTap: (){
      // Navigator.push(context, MaterialPageRoute(builder:(_) {return drawerscreens[index];}));
        Navigator.pushNamed(context, drawerscreens[index]);
      },
    )
      );

    }
    ),

    ),
    ),
      body: Container(
        margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: 200,

              // color: Colors.white,

              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage('assets/images/photo3.jpg'),

                  alignment: Alignment.centerRight
                ),
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
                )
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10.0),

              child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Offer 50%',
                    style: TextStyle(
                        color: Colors.red,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),Text(
                    'Hurry up \nit is limited \nso time offer',
                    style: TextStyle(
                        color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                  Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                    size: 25.0,
                  )

                ],
              ),
            ),
            ListTile(
              leading: Text(
                'Best Sellers',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_){return Result('Best Sellers');}) );

    },
              trailing: Text(
                'See More',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ), Container(
              height: MediaQuery.of(context).size.height/3,
              margin: EdgeInsets.only(bottom: 10.0),
              child: items(false),
            ),
            ListTile(
              leading: Text(
                'Hands-picks',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                ),
              ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {

                      return Result('Hands-picks');

                    }));
                  },
              trailing: Text(
                'See More',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/3,
              margin: EdgeInsets.only(bottom: 10.0),
              child: items(true),
            ),
          ],
        ),
      ),
    );
  }
  item(bool z){
    return  ListView.builder(
        scrollDirection:Axis.horizontal,
        itemCount: itemphoto.length,
        reverse: z,
        itemBuilder:(context,index){
          return Container(
            width: MediaQuery.of(context).size.width/2,
            height: 70,
            margin: EdgeInsets.only(right: 10.0,left: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                    image: AssetImage(itemphoto[index]),
                    fit: BoxFit.fill

                )
            ),


          );
        });
  }
  items(bool z){
    return  ListView.builder(
        scrollDirection: z? Axis.vertical:Axis.horizontal,
        itemCount: itemphoto.length,
        itemBuilder:(context,index){
          return InkWell(
              onTap: (){
                 Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => Details('details',itemphoto[index],itemname[index]),
                     ));
              },
              child:  Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/2.2,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius :BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width/2,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
                          image: DecorationImage(
                              image: AssetImage(itemphoto[index]),
                              fit: BoxFit.fill
                          )
                      ),
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(top: 8.0),
                      child:  IconButton(
                        icon:Icon(Icons.favorite_border) ,
                        color: Colors.red,
                        iconSize: 20.0,
                        onPressed: (){
                          // setState(() {
                          //   fav = !fav;
                          // });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        itemname[index],
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),
                      ),
                      subtitle: Text(
                        'a modern charin with quality wood',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 15.0),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        '\$500',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),
                      ) ,
                      trailing:  IconButton(
                        icon:Icon(Icons.add_shopping_cart) ,
                        color: (Colors.grey),
                        iconSize: 20.0,
                        onPressed: (){
                          setState(() {
                            // fav = !fav;
                          });
                        },
                      ),
                    )
                  ],
                ),
              )
          );


        });
  }
}
