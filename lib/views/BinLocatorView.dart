import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(BinLocatorView());
}

class BinLocatorView extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class _GMAPState extends State<GoogleMap> {
  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = HashSet<Marker>();
    void _onMapCreated(GoogleMapController controller) {}
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

Map <MarkerId, Marker> recyclingBinsLocationsMarkers = <MarkerId,Marker>{};
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    getRecyclingBinsLocationsFromFirestore();
  }
  Future <Position> _getCurrentLocation() async{
    return Future.value(Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best));
  }
  void initiateMarkersInfo(specify,specificId) async{
    var markerIdValue = specificId;
    final MarkerId markerId = MarkerId(markerIdValue);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['location'].latitude,specify['location'].longitude),
      infoWindow: InfoWindow(title: "Reciclame"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    setState(() {
      recyclingBinsLocationsMarkers[markerId] = marker;
    });
  }
 getRecyclingBinsLocationsFromFirestore() async{
     Firestore.instance.collection('location').getDocuments().then((myMockData){
       if(myMockData.documents.isNotEmpty){
         for(int i=0; i<myMockData.documents.length; i++){
              initiateMarkersInfo(myMockData.documents[i].data(), myMockData.documents[i].documentID);
         }
       }
     });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _getCurrentLocation(),
              builder:  (BuildContext context, AsyncSnapshot<Position> snapshot){
                if( snapshot.connectionState == ConnectionState.waiting){
                  return  Center(child: CircularProgressIndicator());
                }else{
                  if (snapshot.hasError){
                    return  Center(child: CircularProgressIndicator());
                  } else{
                    return GoogleMap(
                      markers:Set<Marker>.of(recyclingBinsLocationsMarkers.values),
                      myLocationEnabled: true,
                      compassEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(snapshot.data.latitude,snapshot.data.longitude),
                        zoom: 16,
                      ),
                    );
                  }
                }
              })
        ],
      ),
    );
  }
}
