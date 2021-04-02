import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
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

  @override
  Widget build(BuildContext context) {
String _getData;
  Future<String> get_info() async {
QuerySnapshot doc= await FirebaseFirestore.instance.collection('Covid_info').get();
print(doc.size.toString());
return doc.size.toString();
}


String count = "";
    return MaterialApp(
      home: Scaffold(
      appBar: new AppBar(
      backgroundColor: Color(0xFFF46C6B),
      centerTitle: true,
      title: Row(children: [
        Text(
         'Do you have Covid?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 5), 
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF99E3E), // background
              onPrimary: Colors.white, // foreground
            ),
          child: Text('Yes'),
          onPressed: () async {
            String  current_uid = await Provider.of(context).auth.getCurrentUID();
            final db = FirebaseFirestore.instance;
            db.collection("Covid_info").doc(current_uid).set({'country': "USA"});
            db.collection("Covid_info").doc('information').set({'counts': FieldValue.increment(1)});
            count = await get_info();
            print(count);
          },
        ),
        SizedBox(width: 1), 
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFF99E3E), // background
              onPrimary: Colors.white, // foreground
          ),
          child: Text('No'),
          onPressed: () async {
            String  current_uid = await Provider.of(context).auth.getCurrentUID();
            final db = FirebaseFirestore.instance;
            db.collection("Covid_info").doc(current_uid).delete();
            db.collection("Covid_info").doc('information').set({'counts': FieldValue.increment(0)});
            count = await get_info();
            print(count);
          },
        ),
        Text('cases: ' + count),
     FutureBuilder(
      future: get_info(),
      initialData: "Loading text..",
      builder: (BuildContext context, AsyncSnapshot<String> text) {
        return new SingleChildScrollView(
          padding: new EdgeInsets.all(8.0),
          child: new Text(
            text.data,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
          ));
      })
    //  FutureBuilder(
    //   future: _getData,
    //   initialData: "Loading text..",
    //   builder: (BuildContext context, AsyncSnapshot<String> text) {
    //     return new SingleChildScrollView(
    //       padding: new EdgeInsets.all(8.0),
    //       child: new Text(
    //         text.data,
    //         style: new TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 19.0,
    //         ),
    //       ));
    //   })
    // Text(_getData),
      ]),
    ), 
        body: 
          GoogleMap(
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


