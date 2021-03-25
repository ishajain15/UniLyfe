import 'package:flutter/material.dart';

class RandomizePage extends StatelessWidget {
  bool _hasBeenPressed = false;
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          //onPressed: () {
          //Navigator.push(

          // context, MaterialPageRoute(builder: (context) => StartPage()));
          // },
          onPressed: () => {
            //setState(() {
              _hasBeenPressed = !_hasBeenPressed,
              print(_hasBeenPressed),
            //})
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Randomize Posts',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );


}

setState(bool Function() param0) {}
