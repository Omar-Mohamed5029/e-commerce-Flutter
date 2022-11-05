import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String classname,name,photo;
  Details(this.classname,this.photo,this.name);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List itemphoto =[
    'assets/images/photo4.jpg','assets/images/photo5.jpg','assets/images/photo6.jpg','assets/images/photo7.jpg','assets/images/photo8.jpg'
  ];
  int quantity = 1;
  bool fav =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black,size: 20.0),
          elevation: 0.0,
        ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView(
                  children: [
                    Container(
                      
                      height: MediaQuery.of(context).size.height/2.5,
                      // width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: itemphoto.length,
                          itemBuilder: (context,index){
                          return Container(

                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                
                                image: AssetImage(widget.photo),
                                fit: BoxFit.fill,
                              )
                            ),
                          );
                          }
                       ),
                    ),
                   SizedBox(height: 20.0,),
                   item(widget.name,'chair made of wood,with high quality and can\'t be broken faster than you think so in my opinion buy it'),
                    SizedBox(height: 20.0,),
                    ListTile(
                      title: Text(
                        'Colors',
                        style: TextStyle(color: Colors.black,fontSize:25.0 ,fontWeight: FontWeight.bold),
                      ),
                      trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon:Icon( Icons.color_lens ) ,
                              color: Colors.red,
                              iconSize: 20.0,
                              onPressed: (){ },
                            ),
                            IconButton(
                              icon:Icon( Icons.color_lens ) ,
                              color: Colors.blue,
                              iconSize: 20.0,
                              onPressed: (){ },
                            ),
                            IconButton(
                              icon:Icon( Icons.color_lens ) ,
                              color: Colors.green,
                              iconSize: 20.0,
                              onPressed: (){},
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 15.0,),
                    ListTile(
                      title: Text(
                        'Quantity',
                          style: TextStyle(color: Colors.black,fontSize:25.0 ,fontWeight: FontWeight.bold),
                      ),
                        trailing: DecoratedBox(
                        decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                         child: Row(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             IconButton(
                               icon:Icon( Icons.add ) ,
                               color: Colors.grey,
                               iconSize: 15.0,
                               onPressed: (){
                                 setState(() {
                                  quantity++;
                                 });
                               },

                             ),
                             Text(
                              '${quantity.toString()}',
                               style: TextStyle(color: Colors.black,fontSize:20.0 ,fontWeight: FontWeight.bold),
                             ),
                             IconButton(
                               icon:Icon( Icons.remove ) ,
                               color: Colors.grey,
                               iconSize: 15.0,
                               onPressed: (){
                                 setState(() {
                                   quantity--;
                                 });
                               },

                             )
                           ],
                         ),
                      ),
                    ),
                    // SizedBox(height: 100.0,),


                  ],
                )
            ),
            SafeArea(
                bottom: true,
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[ IconButton(
                      icon:Icon(fav == false ? Icons.favorite_border : Icons.favorite) ,
                      color: Colors.red,
                      iconSize: 25.0,
                      onPressed: (){
                        setState(() {
                          fav = !fav;
                        });
                      },

                    ),
                      TextButton(
                        onPressed: (){

                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold),
                        ),
                          style: TextButton.styleFrom(primary: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                          )

                      )
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
  item(String title, String subtitle){
    return ListTile(
      title: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Text(
        title,
        style: TextStyle(color: Colors.black,fontSize:30.0 ,fontWeight: FontWeight.bold ),),
      )
        ,subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey,fontSize:20.0 ,fontWeight: FontWeight.bold),
        ),
    );
  }
}
