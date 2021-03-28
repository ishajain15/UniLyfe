import 'package:flutter/material.dart';

class InformationButtonFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            showAlertDialog(context);
          },
          icon: Icon(Icons.info_rounded),
          iconSize: 30,
          color: Color(0xFFF99E3E),
        ),
      );
}

// ignore: always_declare_return_types
showAlertDialog(BuildContext context) {
  // set up the button
  // ignore: deprecated_member_use
  Widget dismissButton = RaisedButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text('Dismiss'),
  );

  // set up the AlertDialog
  var alert = AlertDialog(
    title: Text('FOOD'),
    content: Text(
        'In this subpage, users can find posts and reviews of places to eat on campus.'),
    actions: [
      dismissButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
