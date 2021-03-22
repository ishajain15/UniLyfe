import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/comments_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class CommentButtonWidget extends StatelessWidget {
  CommentButtonWidget({Key key, @required this.postid, this.uid})
      : super(key: key);

  final String postid;
  final String uid;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context).auth;
    return Container(
      padding: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () async => showComments(
          context,
          postid: postid,
          uid: await auth.getCurrentUID(),
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
}

// ignore: always_declare_return_types
showComments(BuildContext context, {String postid, String uid}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return CommentsPage(
      postid: postid,
      uid: uid,
    );
  }));
}
