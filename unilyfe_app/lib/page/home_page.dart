import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/buttons/logout_button.dart';
import 'package:unilyfe_app/provider/google_sign_in.dart';

class HomePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
             'Welcome ' + user.displayName,
            //'Welcome ',
            style: TextStyle(color: Colors.orangeAccent),
          ),
          LogoutButtonWidget(),
        ],
      ),
    );
    /*return Scaffold(
      body: Center(
        child: Text("Hello, hi!"),
      ),
    );*/
  }
}
