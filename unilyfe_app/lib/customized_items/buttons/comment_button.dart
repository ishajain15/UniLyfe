import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/comments_page.dart';

class CommentButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () => showComments(
            context,
            //postId: postId,
          ),
          child: Icon(
            Icons.chat,
            size: 28.0,
            color: Colors.grey[900],
          ),
        ),
        // IconButton(
        //   iconSize: 35.0,
        //   icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
        //   onPressed: () => {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => CommentsPage()))
        //   },
        // ),
      );
}

showComments(
  BuildContext context,
  /*{String postId}*/
) {}
