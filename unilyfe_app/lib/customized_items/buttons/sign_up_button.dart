import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unilyfe_app/customized_items/buttons/rounded_button.dart';

class SignUpButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),

        child: RoundedButton(
          text: 'SIGN UP',
          press: () {
            Navigator.of(context).pushReplacementNamed('/signUp');
          },
          color: Color(0xFFF99E3E),
        ),
      );
}
