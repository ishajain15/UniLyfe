import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unilyfe_app/page/register_page.dart';

class SignUpButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          child: Text(
            'SIGN UP',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF99E3E),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );
}
