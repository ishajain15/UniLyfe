import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class LogoutButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: ElevatedButton.icon(
          icon: FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.white),
          label: Text(
            'LOGOUT',
          ),
          onPressed: () async {
            try {
              await Provider.of(context).auth.signOut();
              
            } catch (e) {
              print(e);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFF99E3E),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      );
}

