import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/loading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchMap extends StatefulWidget {
  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  Position position;
  final TextEditingController searchMapController = TextEditingController();
  bool loading = false;
  List <Marker> markers =[];

  searchLoction() async{

    setState(() {
      loading = true;
    });
    var locationServices = await Geolocator().isLocationServiceEnabled();
    var _currentLoction = await Geolocator().getCurrentPosition();
    if(locationServices == false){
      showDialog(
        context:context,
      barrierDismissible: false,
        builder: (BuildContext context){
          return dialog('Location sevices not enalbled please enable it !');
        }

      );
      setState(() {
        loading = false;
      });
    }else if(searchMapController.text.isEmpty){
      setState(() {
        position=_currentLoction;
        loading=false;
      });

    }else{

     List<Placemark> _searchLocation = await Geolocator().placemarkFromAddress(searchMapController.text);
     final Marker _marker= Marker(
       icon: BitmapDescriptor.defaultMarker,
       position: LatLng(_searchLocation[0].position.latitude,_searchLocation[0].position.longitude),
       visible: true,
       infoWindow: InfoWindow(
         title: _searchLocation[0].name,
       ),
       markerId: MarkerId('Your Location'),
     );
     markers.add(_marker);
     setState(() {
       position = _searchLocation[0].position;
       loading=false;
     });

    }
    // setState(() {
    //   position = _currentLoction;
    // });
  }
  dialog(String content){
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text(
        'Note!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
    content,
    style: TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    ),
      ),
      actions: [
        TextButton(
          child:Text(
            'cancel!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ) ,
    style: TextButton.styleFrom(
      primary: Colors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
    ),
          onPressed: (){
            return null;
          },
        ),
        TextButton(
          child:Text(
            'OK',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ) ,
    style: TextButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
    ), onPressed: (){
               return null;
           },
        ),
      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    searchLoction();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          'Delivery Location',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black,size: 20.0),
        bottom: PreferredSize(
          child: TextFormField(
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
              prefixIcon: Icon(Icons.search,color:Colors.black,size: 20.0,),
              labelText: 'ex; cairo',
              labelStyle: TextStyle(color:Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),

            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            controller: searchMapController,
            onFieldSubmitted: (value){
              searchLoction();
            },

          ),
          preferredSize: Size(0.0,40.0),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: loading==true?Center(child: Loading(),):buildMap(),
    );
  }
  buildMap(){
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(position.latitude,position.longitude),
          zoom: 12
      ),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
       markers: Set.from(markers),
    );
  }

}
// actions: <Widget>[
// IconButton(
// icon: Icon(Icons.location_searching),
// onPressed: (){
// Navigator.push(context, MaterialPageRoute(builder: (_){return SearchMap();}));
// },
// )
// ],