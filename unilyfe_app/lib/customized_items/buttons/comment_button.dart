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
      child: IconButton(
        icon: Icon(
          Icons.chat_bubble_outline_rounded,
          size: 28.0,
          color: Colors.grey[500],
        ),
        onPressed: () async {
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
