import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unilyfe_app/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton.icon(
          label: Text(
            'Sign in With Google',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logIn();
          },
        ),
      );
}
