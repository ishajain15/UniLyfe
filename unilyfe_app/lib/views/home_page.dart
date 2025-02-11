import 'package:flutter/material.dart';
import 'package:unilyfe_app/views/post_card.dart';

// HomePage widget
// scrolling list of posts
class Posts extends StatelessWidget {
  const Posts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return PostCard();
        },
      ),
    );
  }
}