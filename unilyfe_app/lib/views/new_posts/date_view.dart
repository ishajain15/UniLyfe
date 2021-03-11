import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/views/new_posts/budget_view.dart';

class NewPostDateView extends StatelessWidget {
  final Post post;
  NewPostDateView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post - Date'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Location: ${post.title}"),
            Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Enter a Start Date'),
                Text('Enter a End Date'),
              ],
            ),
            ElevatedButton(
              child: Text("Continue"),
              onPressed: () {
                post.startDate = DateTime.now();
                post.endDate = DateTime.now();
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => NewPostBudgetView(post: post)),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}