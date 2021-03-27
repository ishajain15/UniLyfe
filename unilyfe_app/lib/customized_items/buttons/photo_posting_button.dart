import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class PhotoPostingButton extends StatelessWidget {
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
            'Post',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}
