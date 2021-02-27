import 'package:flutter/material.dart';
import 'package:unilyfe_app/widget/google_button.dart';

class SignUpWidget extends StatelessWidget {
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
          Spacer(),
          GoogleSignupButtonWidget(),
          SizedBox(height: 12),
          Spacer(),
        ],
      );
}
