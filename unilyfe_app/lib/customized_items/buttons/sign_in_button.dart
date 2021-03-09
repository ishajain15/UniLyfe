import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unilyfe_app/customized_items/buttons/rounded_button.dart';

class SignInButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: RoundedButton(
          text: 'SIGN IN',
          press: () {
            Navigator.of(context).pushReplacementNamed('/signIn');
          },
        ),
      );
}
