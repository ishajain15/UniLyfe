import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:unilyfe_app/page/got_covid.dart';
import '../src/locations.dart' as locations;

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
  static const double minExtent = 0.13;
  static const double maxExtent = 0.9;

  bool isExpanded = false;
  double initialExtent = minExtent;
  double currExtent = minExtent;
  BuildContext draggableSheetContext;

  Widget build(BuildContext context) {
    void _toggleDraggableScrollableSheet() {
      if (draggableSheetContext != null) {
        setState(() {
          initialExtent = isExpanded ? minExtent : maxExtent;
          isExpanded = !isExpanded;
        });
        DraggableScrollableActuator.reset(draggableSheetContext);
      }
    }

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
          InkWell(
            onTap: _toggleDraggableScrollableSheet,
            child: DraggableScrollableSheet(
              key: Key(initialExtent.toString()),
              initialChildSize: initialExtent,
              minChildSize: minExtent,
              maxChildSize: maxExtent,
              builder: (BuildContext context, scrollController) {
                draggableSheetContext = context;
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
                      child: (!isExpanded)
                          ? Icon(Icons.keyboard_arrow_up_rounded,
                              color: Colors.grey)
                          : Icon(Icons.keyboard_arrow_down_rounded,
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
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                  ),
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
                                        if (!isExpanded) resetChanged();
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
          ),
        ],
      )),
    );
  }
}
