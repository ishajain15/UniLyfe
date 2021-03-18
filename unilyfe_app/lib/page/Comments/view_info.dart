import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/back_button.dart';
import 'package:unilyfe_app/customized_items/buttons/lets_go_button.dart';
import 'package:unilyfe_app/customized_items/buttons/poll_viewButton.dart';

class ViewInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment : CrossAxisAlignment.center,
        children: <Widget> [
          Spacer(),
          Container(
            child: Text("Information about post"),
          ),
          PollViewButton(),
          SizedBox(height: 10),
           ElevatedButton(
               child: Text("Go back"),
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          Spacer(),
        ],
      ));
}
