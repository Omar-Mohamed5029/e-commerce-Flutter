import 'package:flutter/material.dart';
import 'package:flutter_course/screens/bottomNavBar/search.dart';
import 'package:flutter_course/widgets/item.dart';
import 'package:flutter_course/widgets/searchmap.dart';
class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List itemphoto =[
    'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
    ,'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
    ,  'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
    ,'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
  ];
  List itemName=['Beige Chair','White Chair','Red Chair','Grey Chair','White Sofa',
    'Beige Chair','White Chair','Red Chair','Grey Chair','White Sofa',
    'Beige Chair','White Chair','Red Chair','Grey Chair','White Sofa',
    'Beige Chair','White Chair','Red Chair','Grey Chair','White Sofa'];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Shopping cart',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black,size: 20.0),
        actions: <Widget>[
         IconButton(
           icon: Icon(Icons.location_searching),
           onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (_){return SearchMap();}));
           },
         )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body:Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                 scrollDirection: Axis.vertical,
                  itemCount: itemName.length,
                  itemBuilder: (context,index){
                   return Container(
                     margin: EdgeInsets.only(bottom: 10.0),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(15.0),

                     ),
                     child: (ListTile(
                       leading: Image.asset(itemphoto[index]),
                       title: Text(
                         itemName[index],
                         style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),
                       ),
                       trailing: Icon(Icons.delete,color:Colors.grey ,size: 20,),
                     )),
                   );
                  }),
            ),
            SafeArea(
              bottom: true,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: ListTile(
                    title: Text(
                    'Total Amount is 200\$',
                    style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.bold),
                  ),
                    subtitle: Text(
                    '3 Item',
                    style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.bold),
                  ),
                  ),
                )),
          ],
        ),
      ) ,
    );
  }
}










// Container(
// margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
// child: GridView.builder(
// gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// mainAxisSpacing: 10.0,
// childAspectRatio: 0.7,
// crossAxisSpacing: 10.0
// ) ,
// scrollDirection: Axis.vertical,
// itemCount: itemphoto.length,
// itemBuilder: (context,index){
// return Item(itemphoto[index],'shoppingCart');
