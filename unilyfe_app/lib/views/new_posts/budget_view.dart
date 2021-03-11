import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPostBudgetView extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  final Post post;
  NewPostBudgetView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post - Budget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Finish'),
            Text("Location ${post.title}"),
            Text("State Date ${post.startDate}"),
            Text("End Date ${post.endDate}"),
            
            ElevatedButton(
              child: Text("Continue"),
              onPressed: () async {
                // save data to firebase
                await db.collection("posts").add(
                  {
                    'title': post.title,
                    'startDate': post.startDate,
                    'endDate': post.endDate,
                  }
                );

                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            ),
          ],
        ),
      ),
    );
  }
}