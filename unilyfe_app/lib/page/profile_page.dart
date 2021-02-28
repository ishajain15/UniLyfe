import 'package:flutter/material.dart';
//import 'package:unilyfe_app/buttons/logout_button.dart';
//import 'package:unilyfe_app/provider/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'random stuff for now',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          //LogoutButtonWidget(),
        ],
      ),
    );
  }
}