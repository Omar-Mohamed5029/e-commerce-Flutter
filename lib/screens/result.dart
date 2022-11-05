import 'package:flutter/material.dart';
import 'package:flutter_course/screens/bottomNavBar/contact.dart';
import 'package:flutter_course/screens/drawer/about.dart';
import 'package:flutter_course/widgets/item.dart';

class Result extends StatefulWidget {
  final String className;
  Result(this.className);
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
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
  String filter='None';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black,size: 20.0),
        elevation: 0.0,
        title: Text(
          widget.className
              ,style: TextStyle(color: Colors.black,fontSize:20.0 ,fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          child: ListTile(
            leading: Text(
              '${itemphoto.length} items - ${filter}'
                  ,style: TextStyle(color: Colors.black,fontSize:20.0 ,fontWeight: FontWeight.bold) ,

            ),
            trailing:PopupMenuButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              icon:Icon( Icons.filter_list,color: Colors.black,size: 20.0,),
              itemBuilder: (BuildContext contex){
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    child: Text(
                      'Popular',
                      style: TextStyle(color:Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),
                    ),value: 'Popular', ),
                  PopupMenuItem(
                    child: Text(
                      'Best Seller',
                      style: TextStyle(color:Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),
                    ),value: 'Best Seller', ),
                ];
              },
              onSelected: (value){
                setState(() {
                  filter = value;
                });
              },
            ),
          ),
          preferredSize: Size(0.0,40.0),

        ),
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
              return Item(itemphoto[index],'result' , itemname[index],120.0);
            }
        ),
      ),
    );
  }
}
