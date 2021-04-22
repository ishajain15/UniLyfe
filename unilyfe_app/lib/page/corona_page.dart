import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unilyfe_app/page/got_covid.dart';
import 'dart:ui' as ui;

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> with TickerProviderStateMixin {
  TabController _controller;
  // final placesProvider = PlacesProvider();
  // List<PlaceSearch> searchResults;

  Future<String> get_info() async {
    var doc = await FirebaseFirestore.instance.collection('Covid_info').get();
    print(doc.size.toString());
    numbers = doc.size;
    return doc.size.toString();
  }

  void updateMarker() {
    setState(() {
      getMarkerData();
    });
  }

  // searchPlaces(String searchTerm) async {
  //   searchResults = await placesProvider.getAutoComplete(searchTerm);
  // }

  @override
  void initState() {
    getMarkerData();
    super.initState();

    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int numbers = 0;
  static const double minExtent = 0.13;
  static const double maxExtent = 0.9;

  bool isExpanded = false;
  double initialExtent = minExtent;
  double currExtent = minExtent;
  BuildContext draggableSheetContext;
  GoogleMapController myController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void initMarker(specify, specifyId) async {
    var idVal = specifyId;
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/red_dot.png', 40);

    final MarkerId markerId = MarkerId(idVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: //LatLng(40.4229446, -86.9115997),
          LatLng(specify['coordinates'].latitude,
              specify['coordinates'].longitude),
      icon: BitmapDescriptor.fromBytes(markerIcon),
    );
    //print(marker.position.toString());
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    await FirebaseFirestore.instance
        .collection('locations')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var i = 0; i < value.docs.length; i++) {
          initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }

  @override
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

    Set<Marker> getMarker() {
      return <Marker>{
        Marker(
          markerId: MarkerId('COVID CASE'),
          position: LatLng(40.42395040517343, -86.92120533110851),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'COVID CASE'),
        )
      };
    }

    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              myController = controller;
            }, // _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(40.42395040517343, -86.92120533110851),
              zoom: 15,
            ),
            markers: Set<Marker>.of(markers.values),
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 15,
                                    height: 45,
                                  ),
                                  Text(
                                    'LOCATIONS AND THEIR COVID CASES: ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ]),
                            StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('location_cases')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text('Loading...');
                                  }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              buildPostCard(context,
                                                  snapshot.data.docs[index]));
                                }),
                          ]),
                          GotCovidPage(updateMarker: updateMarker),
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

  Widget buildPostCard(BuildContext context, DocumentSnapshot location) {
    return Column(children: <Widget>[
      ListTile(
        dense: true,
        title: Row(children: <Widget>[
          Text(location['name']),
          Spacer(),
          Text(location['num_cases'].toString())
        ]),
      ),
      Divider(),
    ]);
  }
}
