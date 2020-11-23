import 'dart:collection';

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

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future <Position> _getCurrentLocation() async{
    return Future.value(Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best));
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
                    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
                    final Marker marker = Marker(
                      markerId: MarkerId('currentLocation'),
                      position: LatLng(snapshot.data.latitude,snapshot.data.longitude),
                      infoWindow: InfoWindow(title: 'Me'),
                    );
                    markers[MarkerId('currentLocation')] = marker;
                    return GoogleMap(
                      markers:Set<Marker>.of(markers.values),
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
