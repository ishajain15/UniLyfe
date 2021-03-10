import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/polls_post_button.dart';
import 'package:unilyfe_app/customized_items/buttons/text_post_button.dart';
import 'package:unilyfe_app/customized_items/buttons/picture_post_button.dart';
class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(),
          Align(
            //alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Which type of post?'),
            ),
          ),
          SizedBox(height: 12),
          PollsButton(),
          TextsButton(),
          PictureButton(),
          Spacer(),
        ],
      ));
}
