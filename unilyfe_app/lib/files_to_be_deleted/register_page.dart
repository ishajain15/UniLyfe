import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/back_button.dart';

class RegisterPage extends StatelessWidget {
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
              child: Text('Register'),
            ),
          ),
          SizedBox(height: 12),
          BackButtonWidget(),
          Spacer(),
        ],
      ));
}
