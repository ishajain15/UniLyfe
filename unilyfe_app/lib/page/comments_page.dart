import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

final commentsRef = FirebaseFirestore.instance.collection('comments');

class CommentsPage extends StatefulWidget {
  final String postid;
  final String uid;

  CommentsPage({this.postid, this.uid});

  @override
  createState() => CommentsPageState(
        postid: postid,
        uid: uid,
      );
}

class CommentsPageState extends State<CommentsPage> {
  TextEditingController commentController = TextEditingController();
  final String postid;
  final String uid;
  CommentsPageState({this.postid, this.uid});

  buildComments() {
    return StreamBuilder(
      stream: commentsRef
          .doc(postid)
          .collection('comments')
          //.orderBy("time", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<Comment> comments = [];
        snapshot.data.docs.forEach((doc) {
          comments.add(Comment.fromDocument(doc));
        });
        return ListView(
          children: comments,
        );
      },
    );
  }

  addComment() {
    commentsRef.doc(postid).collection("comments").add({
      "comment": commentController.text,
      //"time": DateTime.now(),
      "uid": uid,
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: "Write a comment..."),
            ),
            trailing: OutlinedButton(
              onPressed: addComment,
              child: Text("Post"),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  //Comment({this.username, this.uid, this.comment, this.time});
  Comment({this.username, this.uid, this.comment});
  final String username;
  final String uid;
  final String comment;
  //final DateTime time;

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      uid: doc['uid'],
      comment: doc['comment'],
      //time: doc['time'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
          ),
          //subtitle: Text(time.toString()),
        ),
        Divider(),
      ],
    );
  }
}
