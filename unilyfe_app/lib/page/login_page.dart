import 'package:flutter/material.dart';
import 'package:unilyfe_app/widget/back_button.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(),
          Align(
            //alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Login'),
            ),
          ),
          SizedBox(height: 12),
          BackButtonWidget(),
          Spacer(),
        ],
      ));
}
