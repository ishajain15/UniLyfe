import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/comments_page.dart';

class CommentButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: IconButton(
          iconSize: 35.0,
          icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CommentsPage()))
          },
        ),
      );
}
