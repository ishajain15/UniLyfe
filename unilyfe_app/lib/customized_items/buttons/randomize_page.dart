import 'package:flutter/material.dart';

bool _hasBeenPressed = false;

class RandomizePage extends StatelessWidget {
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
            print('on press: the randomized button has been clicked'),
            //print(_hasBeenPressed),
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


// ignore: missing_return
bool randomizing_criteria() {
  if (_hasBeenPressed == true) {
    //print("randomize criteria: the randomize button has been clicked");
    return true;
  } 
}

}


