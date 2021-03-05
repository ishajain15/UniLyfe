import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unilyfe_app/Login/components/background.dart';
import 'package:unilyfe_app/page/register_page.dart';
import 'package:unilyfe_app/Signup/signup_screen.dart';
import 'package:unilyfe_app/Signup/already_have_an_account_acheck.dart';
import 'package:unilyfe_app/Signup/rounded_button.dart';
import 'package:unilyfe_app/Signup/rounded_input_field.dart';
import 'package:unilyfe_app/Signup/rounded_password_field.dart';


class Body extends StatelessWidget {
  // const Body({
  //   Key key,
  // }) : super(key: key);
  String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {this._email = value.trim();},
            ),
            RoundedPasswordField(
              onChanged: (value) {this._password = value.trim();},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                auth.signInWithEmailAndPassword(email: _email, password: _password);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));},
            ),
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

