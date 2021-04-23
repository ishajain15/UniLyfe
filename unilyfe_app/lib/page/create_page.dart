import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/events_button.dart';
import 'package:unilyfe_app/customized_items/buttons/polls_post_button.dart';
import 'package:unilyfe_app/customized_items/buttons/reviews_button.dart';
import 'package:unilyfe_app/customized_items/buttons/text_post_button.dart';
import 'package:unilyfe_app/customized_items/buttons/picture_post_button.dart';
import 'package:unilyfe_app/models/post.dart';

class CreatePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CreatePage(),
      );

  @override
  Widget build(BuildContext context) {
    // ignore: equal_elements_in_set
    final newPost = Post(null, null, null, null, null, null, 0, false, {}, null, null, null, null, null);
    return Scaffold(
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
            ReviewsButton(
            ),
            PollsButton(),
            TextsButton(
              newPost: newPost,
            ),
            EventsButton(),
            PictureButton(),
            Spacer(),
          ],
        ));
  }
}
/*hiiii*/
