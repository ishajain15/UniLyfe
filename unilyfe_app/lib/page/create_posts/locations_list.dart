import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/page/create_posts/location_rating.dart';
import 'package:unilyfe_app/views/new_posts/submit_view.dart';

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
      body: Column(
        //child: Container(
          children: [
          //padding: const EdgeInsets.all(100.0),
          //color: Color(0xFFF46C6B),
          DropdownButton<String>(
            value: chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: <String>[
              'Earhart Dining Court',
              'Wiley Dining Court',
              'Windsor Dining Court',
              'Hillenbrand Dining Court',
              'Harrison Grill',
              'Triple XXX Family Restaurant',
              'Einstein Bagels',
              'Earhart Residence Hall',
              'Wiley Residence Hall',
              'Windsor Residence Hall',
              'Hillenbrand Residence Hall',
              'Chauncey Square Apartments',
              'Aspire at Discovery Park',
              'Hub State Street',
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
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocationRating()),
                  );
                },
                child: Text('Continue')),
          ],
      ),
      
    );
    
  }
}
