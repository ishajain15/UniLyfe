import 'package:flutter/material.dart';
import 'package:unilyfe_app/views/comment_history_view.dart';

class CommentHistoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommentHistoryView()),
            );
          },
          style: TextButton.styleFrom(
            primary: Colors.grey,
          ),
          child: Text(
            'View Comment History',
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
}
