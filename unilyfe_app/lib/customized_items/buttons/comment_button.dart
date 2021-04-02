import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/comments_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class CommentButtonWidget extends StatelessWidget {
  CommentButtonWidget({Key key, @required this.postid, this.uid, this.username})
      : super(key: key);

  final String postid;
  final String uid;
  final String username;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context).auth;

    return Container(
      padding: EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () async {
          var uid = await auth.getCurrentUID();
          showComments(
            context,
            postid: postid,
            uid: uid,
            username:
                await db.collection('userData').doc(uid).get().then((result) {
              return result['username'];
            }),
          );
        },
        child: Icon(
          Icons.chat,
          size: 28.0,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}

// ignore: always_declare_return_types
showComments(BuildContext context,
    {String postid, String uid, String username}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return CommentsPage(
      postid: postid,
      uid: uid,
      username: username,
    );
  }));
}
