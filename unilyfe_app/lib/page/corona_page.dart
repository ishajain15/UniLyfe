import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../src/locations.dart' as locations;

class CoronaPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CoronaPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ayo its coronatime'),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  /* // code for adding pins
  BitmapDescriptor pinLocationIcon;
   @override
   void initState() {
      super.initState();
      setCustomMapPin();
   }
   void setCustomMapPin() async {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/destination_map_marker.png');
   }

  @override
Widget build(BuildContext context) {
   LatLng pinPosition = LatLng(37.3797536, -122.1017334);
   
   // these are the minimum required values to set 
   // the camera position 
   CameraPosition initialLocation = CameraPosition(
      zoom: 16,
      bearing: 30,
      target: pinPosition
   );
}
//end code for pins */
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /* appBar: AppBar(
          title: const Text('Google Office Locations'),
          backgroundColor: Colors.green[700],
        ), */
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(40.42395040517343, -86.92120533110851),
            zoom: 5,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}