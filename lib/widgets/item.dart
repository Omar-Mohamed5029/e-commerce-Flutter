import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/details.dart';

class Item extends StatefulWidget {
  final String itemphoto;
  final String className;
  final String itemName;
  
  final double height;

  Item(this.itemphoto,this.className,this.itemName,this.height);
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool fav ;
  bool shopping;
  check(){
    if(widget.className == 'shoppingCart') {
      fav = false;
      shopping =true;
    }else if(widget.className =='wishList'){

    } else {
      fav = false;
      shopping =false;
    }
  }
  @override
  void initState() {
   check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details('details',widget.itemphoto,widget.itemName),
            ));
      },
        child:  Container(
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius :BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
              image: DecorationImage(
                image: AssetImage(widget.itemphoto),
                fit: BoxFit.fill
              )
            ),
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 8.0),
              child:  IconButton(
                icon:Icon(fav == false ? Icons.favorite_border : Icons.favorite) ,
                color: Colors.red,
                iconSize: 20.0,
                onPressed: (){
                  setState(() {
                    fav = !fav;
                  });
                },
              ),
            ),
          ListTile(
            title: Text(
              widget.itemName,
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
              color: (shopping == true ? Colors.black : Colors.grey),
              iconSize: 20.0,
              onPressed: (){
                setState(() {
                  fav = !fav;
                });
              },
            ),
          )
        ],
      ),
    )
    );
  }
}
