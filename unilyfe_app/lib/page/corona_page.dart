import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CoronaPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CoronaPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ayo its coronatime"),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => MyMap(),
      );
  GoogleMapController mapController;

  final LatLng _center = const LatLng(40.42395040517343, -86.92120533110851);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        /* appBar: AppBar(
          toolbarHeight: 25,
          title: Text('COVID-19 Tracker'),
          backgroundColor: Color(0xFFF47C54),
        ),*/
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
