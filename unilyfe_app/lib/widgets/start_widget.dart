import 'package:flutter/material.dart';
import 'package:unilyfe_app/buttons/google_button.dart';
import 'package:unilyfe_app/buttons/sign_in_button.dart';
import 'package:unilyfe_app/buttons/sign_up_button.dart';

class StartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => buildSignUp();

  Widget buildSignUp() => Column(
        children: [
          Spacer(),
          Align(
            //alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset('assets/logo.png', fit: BoxFit.contain),
            ),
          ),
          SignInButtonWidget(),
          SignUpButtonWidget(),
          GoogleButtonWidget(),
          SizedBox(height: 12),
          Spacer(),
        ],
      );
}
