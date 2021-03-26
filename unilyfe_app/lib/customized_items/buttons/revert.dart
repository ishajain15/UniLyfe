import 'package:flutter/material.dart';

bool _hasBeenPressed = false;

class RevertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.topLeft,
        child: ElevatedButton(
          //onPressed: () {
          //Navigator.push(

          // context, MaterialPageRoute(builder: (context) => StartPage()));
          // },
          onPressed: () => {
            //setState(() {
            _hasBeenPressed = !_hasBeenPressed,
            //print(_hasBeenPressed),
            print("the revert button has been clicked"),
            //})
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Revert Changes',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );


bool revert_criteria() {
  if (_hasBeenPressed == true) {
    print("the revert button has been clicked");
    return true;
  } 
}

}


