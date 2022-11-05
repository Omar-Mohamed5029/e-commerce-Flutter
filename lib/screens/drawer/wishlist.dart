import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/item.dart';

class WishList extends StatefulWidget {
  // final String className;
  // Result(this.className);
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List itemphoto =[
    'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
    ,'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
    ,  'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
    ,'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
  ];
  List itemname =[
    'yellow chiar','white chair','red chair','gery chair','gery sofa',
    'yellow chiar','white chair','red chair','gery chair','gery sofa',
    'yellow chiar','white chair','red chair','gery chair','gery sofa',
    'yellow chiar','white chair','red chair','gery chair','gery sofa',

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Wish List',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black,size: 20.0),
        actions: <Widget>[
          Icon(
            Icons.favorite,
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: GridView.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10.0
            ) ,
            scrollDirection: Axis.vertical,
            itemCount: itemphoto.length,
            itemBuilder: (context,index){
              return Item(itemphoto[index],'wishList',itemname[index],120.0);
            }
        ),
      ),
    );
  }
}
