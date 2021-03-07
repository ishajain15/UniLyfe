import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unilyfe_app/Signup/rounded_button.dart';
// import 'package:unilyfe_app/page/register_page.dart';
import 'package:unilyfe_app/Signup/signup_screen.dart';

class SignUpButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        /*child: ElevatedButton(
          child: Text(
            'SIGN UP',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF99E3E),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),


        ),*/

        child: RoundedButton(
          text: "SIGN UP",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          color: Color(0xFFF99E3E),
        ),
      );
}
