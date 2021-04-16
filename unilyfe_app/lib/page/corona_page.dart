import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unilyfe_app/page/got_covid.dart';
import 'package:unilyfe_app/views/food_view.dart';
import 'package:unilyfe_app/views/home_view.dart';
import 'package:unilyfe_app/views/social_view.dart';
import 'package:unilyfe_app/views/study_view.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import '../src/locations.dart' as locations;

// class CoronaPage extends StatelessWidget {
//   static Route<dynamic> route() => MaterialPageRoute(
//         builder: (context) => CoronaPage(),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('ayo its coronatime'),
//       ),
//     );
//   }
// }

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> with TickerProviderStateMixin {
  TabController _controller;
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

  Future<String> get_info() async {
    var doc = await FirebaseFirestore.instance.collection('Covid_info').get();
    print(doc.size.toString());
    numbers = doc.size;
    return doc.size.toString();
  }

  @override
  void initState() {
    super.initState();

    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  int numbers = 0;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(40.42395040517343, -86.92120533110851),
              zoom: 15,
            ),
            markers: _markers.values.toSet(),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.13,
            minChildSize: 0.13,
            maxChildSize: 0.9,
            builder: (BuildContext context, scrollController) {
              return Container(
                  child: ListView(
                controller: scrollController,
                children: [
                  Container(
                    height: 6,
                    color: Colors.white,
                    child: Spacer(),
                  ),
                  Container(
                    height: 22,
                    color: Colors.white,
                    child: Icon(Icons.keyboard_arrow_up_rounded,
                        color: Colors.grey),
                  ),
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _controller,
                      labelColor: const Color(0xFFF56D6B),
                      tabs: [
                        Tab(text: 'INFO'),
                        Tab(text: 'GOT COVID?'),
                      ],
                      unselectedLabelColor: Colors.grey,
                    ),
                  ),
                  Container(
                    height: 500,
                    alignment: Alignment.topCenter,
                    color: Colors.white,
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'NUMBER OF CASES: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                FutureBuilder(
                                    future: get_info(),
                                    initialData: 'Loading text..',
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> text) {
                                      return SingleChildScrollView(
                                          padding: EdgeInsets.all(8.0),
                                          child: (isChanged())
                                              ? Text(
                                                  (numbers + getBalance())
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                )
                                              : Text(
                                                  (numbers).toString(),
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                ));
                                    }),
                              ]),
                        ]),
                        GotCovidPage(),
                      ],
                    ),
                  ),
                ],
              ));
            },
          ),
        ],
      )),
    );
  }
}
