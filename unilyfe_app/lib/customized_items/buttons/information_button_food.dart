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

showAlertDialog(BuildContext context) {
  // set up the button
  Widget dismissButton = RaisedButton(
    child: Text("Dismiss"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("FOOD"),
    content: Text(
        "In this subpage, users can find posts and reviews of places to eat on campus."),
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
