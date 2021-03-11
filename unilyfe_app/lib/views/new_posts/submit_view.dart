import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class NewPostBudgetView extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final Post post;
  NewPostBudgetView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Finish'),
            Text("title ${post.title}"),
            Text("time ${post.time}"),
            ElevatedButton(
                child: Text("Continue"),
                onPressed: () async {
                  // save data to firebase
                  final uid = await Provider.of(context).auth.getCurrentUID();
                  post.uid = uid;
                  await db.collection("posts").add(post.toJson());

                  await db
                      .collection("userData")
                      .doc(uid)
                      .collection("posts")
                      .add(post.toJson());

                  Navigator.of(context).popUntil((route) => route.isFirst);
                }),
          ],
        ),
      ),
    );
  }
}
