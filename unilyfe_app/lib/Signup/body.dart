import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/register_page.dart';
import 'package:unilyfe_app/Login/login_screen.dart';
import 'package:unilyfe_app/Signup/background.dart';
import 'package:unilyfe_app/Signup/or_divider.dart';
import 'package:unilyfe_app/Signup/social_icon.dart';
import 'package:unilyfe_app/Signup/already_have_an_account_acheck.dart';
import 'package:unilyfe_app/Signup/rounded_button.dart';
import 'package:unilyfe_app/Signup/rounded_input_field.dart';
import 'package:unilyfe_app/Signup/rounded_password_field.dart';
import 'package:unilyfe_app/page/username_page.dart';

class Body extends StatelessWidget {
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
              "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {this._email = value.trim();},
            ),
            RoundedPasswordField(
              onChanged: (value) {
                this._password = value.trim();
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                auth.createUserWithEmailAndPassword(email: _email, password: _password);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UsernamePage()));
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            // OrDivider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocalIcon(
            //       iconSrc: "assets/icons/facebook.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/twitter.svg",
            //       press: () {},
            //     ),
            //     SocalIcon(
            //       iconSrc: "assets/icons/google-plus.svg",
            //       press: () {},
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
