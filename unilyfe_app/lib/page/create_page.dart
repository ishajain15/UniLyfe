import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/buttons/polls_post_button.dart';
import 'package:unilyfe_app/customized_items/buttons/text_post_button.dart';
import 'package:unilyfe_app/customized_items/buttons/picture_post_button.dart';
import 'package:unilyfe_app/models/post.dart';

class CreatePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CreatePage(),
      );

  @override
  // Widget build(BuildContext context) {

  //   return Scaffold(
  //     body: Center(
  //       child: Text('Hello, create page!'),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       backgroundColor: const Color(0xFFF56D6B),

  //       onPressed: () {
  //         // Navigator.push(
  //         //   context, MaterialPageRoute(builder: (context) => Options()));
  //       },

  //       //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
  //       shape: RoundedRectangleBorder(),
  //       child: Icon(Icons.add,),
  // ),

  //   );

  // }
  Widget build(BuildContext context) {
    // ignore: equal_elements_in_set
    final newPost = Post(null, null, null, null, null, null, 0, false, {});
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
            PollsButton(),
            TextsButton(
              newPost: newPost,
            ),
            PictureButton(),

            // IconButton(
            //   icon: Icon(Icons.add, color: Colors.orange,),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => NewPostLocationView(post: newPost, )),
            //     );
            //   },
            // ),
            Spacer(),
          ],
        ));
  }
}
