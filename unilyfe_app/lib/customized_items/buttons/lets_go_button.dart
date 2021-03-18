import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:unilyfe_app/page/start_page.dart';
import 'package:unilyfe_app/page/tabs/tabs_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class LetsGoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () {
            final auth = Provider.of(context).auth;
            auth.setNewUser(false);
            Navigator.of(context).pushReplacementNamed('/home');
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF46C6B),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Let\'s Go!',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}
