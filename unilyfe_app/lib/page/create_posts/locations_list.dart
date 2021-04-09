import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/dropdown.dart';
import 'package:unilyfe_app/models/post.dart';

// class LocationList extends StatefulWidget {
//   @override
//   LocationsListState createState() => LocationsListState();
// }

class LocationList extends StatefulWidget {
  LocationList({Key key, @required this.post}) : super(key: key);
  LocationsListState createState() => LocationsListState();
  final Post post;
}

class LocationsListState extends State<LocationList> {
  String chosenValue;

  @override
  Widget build(BuildContext context) {
    //var _titleController = TextEditingController();
    //_titleController.text = post.title;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'CREATE A REVIEW POST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(0.0),
          //color: Color(0xFFF46C6B),
          child: DropdownButton<String>(
            value: chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: <String>[
              'Earhart Dining Court',
              'Wiley Dining Court',
              'Windsor Dining Court',
              'Hillenbrand Dining Court',
              'Earhart Hall',
              'Wiley Residence Hall',
              'Windsor Residence Hall',
              'Hillenbrand Hall',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "Choose a location",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            onChanged: (String value) {
              setState(() {
                chosenValue = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
