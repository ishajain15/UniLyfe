import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:unilyfe_app/customized_items/buttons/information_button_food.dart';
import '../src/locations.dart' as locations;

import 'package:unilyfe_app/customized_items/buttons/information_button_covid.dart';

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
    return MaterialApp(
      home: Scaffold(
        body: 
          //InformationButtonCovid(),
          GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(40.42395040517343, -86.92120533110851),
            zoom: 6,
          ),
          markers: _markers.values.toSet(),
        ),
        ),
    );
  }



  @override
  Widget build2(BuildContext context) {
    return Container(
      //InformationButtonFood(),
      //InformationButtonStudy(),
      //InformationButtonSocial(),

      child: Column(
        children: [
          InformationButtonCovid(),
          /* Flexible(
            child: StreamBuilder(
                stream: getUserPostsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return new ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildPostCard(context, snapshot.data.docs[index]));
                }),
          ), */
        ],
      ),
    );
  }
}



