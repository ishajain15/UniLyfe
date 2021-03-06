import 'package:flutter/material.dart';
import 'package:unilyfe_app/buttons/back_button.dart';

class UsernamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(),
          TextFormField(
            decoration: InputDecoration(labelText: 'Enter your username'),
          ),
          SizedBox(height: 12),
          BackButtonWidget(),
          Spacer(),
        ],
      ));
}
