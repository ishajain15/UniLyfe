import 'package:flutter/material.dart';
import 'package:unilyfe_app/buttons/back_button.dart';
import 'package:unilyfe_app/buttons/lets_go_button.dart';

class UsernamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget> [
          Spacer(),
          Container(
            child: TextField(
              autofocus: false,
              style: TextStyle(fontSize: 22.0, color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFfae9d7),
                hintText: 'Enter your username...',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25.7),
                ),
              ),
            ),
          ),
        
          SizedBox(height: 10),
          BackButtonWidget(),
          LetsGoButton(),
          Spacer(),
        ],
      ));
}
