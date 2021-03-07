import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:unilyfe_app/provider/google_sign_in.dart';
//import 'package:provider/provider.dart';

class GoogleButtonWidget extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const GoogleButtonWidget({
    this.text,
    this.press,
    this.color = const Color(0xFFF46C6B),
    this.textColor = Colors.white,
  });

/*
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton.icon(
          label: Text(
            'SIGN IN WITH GOOGLE',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
          onPressed: press,
            // final provider =
            //     Provider.of<GoogleSignInProvider>(context, listen: false);
            // provider.logIn();
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ElevatedButton.icon(
          label: AutoSizeText(
            'SIGN IN WITH GOOGLE',
            style: TextStyle(color: textColor),
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          icon: FaIcon(
            FontAwesomeIcons.google,
            color: Colors.white,
            size: 18,
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            primary: color,
          ),
          onPressed: press,
        ),
      ),
    );
  }
}
