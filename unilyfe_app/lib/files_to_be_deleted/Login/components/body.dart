import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unilyfe_app/files_to_be_deleted/Login/components/background.dart';
import 'package:unilyfe_app/files_to_be_deleted/signup_screen.dart';
import 'package:unilyfe_app/files_to_be_deleted/already_have_an_account_acheck.dart';
//import '.../customized_items/buttons/rounded_button.dart';
import 'package:unilyfe_app/files_to_be_deleted/rounded_input_field.dart';
import 'package:unilyfe_app/files_to_be_deleted/rounded_password_field.dart';
import 'package:unilyfe_app/page/username_page.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: 'Your Email',
              onChanged: (value) {
                _email = value.trim();
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _password = value.trim();
              },
            ),
            /*RoundedButton(
              text: 'LOGIN',
              press: () {
                auth.signInWithEmailAndPassword(
                    email: _email, password: _password);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => UsernamePage()));
              },
            ),*/
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
