import 'package:flutter/material.dart';

class CoronaPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CoronaPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: //AppBar(
        /*leading: new IconButton(
          color: Colors.grey,
          icon: new Icon(Icons.reorder),
          //onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),*/
        //title: Image.asset('assets/unilyfe_logo.png', width: 300, height: 55),
        //backgroundColor: const Color(0xFFFFFFFF),
        TabBar(
          labelColor: const Color(0xFFF56D6B),
          tabs: [
            Tab(text: "ALL"),
            Tab(text: "FOOD"),
            Tab(text: "STUDY"),
            Tab(text: "SOCIAL"),
          ],
          unselectedLabelColor: Colors.grey,
        ),
      //),
      body: TabBarView(
        children: [
          Icon(Icons.directions_car),
          Icon(Icons.directions_transit),
          Icon(Icons.directions_bike),
          Icon(Icons.directions_bike),
        ],
      ),
    );
  }
}
