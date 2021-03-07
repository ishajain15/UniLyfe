import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:unilyfe_app/page/login_page.dart';
import 'package:unilyfe_app/Login/login_screen.dart';
import 'package:unilyfe_app/Signup/rounded_button.dart';
import 'package:unilyfe_app/Signup/signup_screen.dart';

class SignInButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        /*child: ElevatedButton(
          child: Text(
            'SIGN IN',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ),*/
        child: RoundedButton(
          text: "SIGN IN",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      );
}
