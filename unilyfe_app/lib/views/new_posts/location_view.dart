import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/views/new_posts/date_view.dart';

class NewPostLocationView extends StatelessWidget {
  final Post post;
  NewPostLocationView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    _titleController.text = post.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post - Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter a Location'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            ElevatedButton(
              child: Text("Continue"),
              onPressed: () {
                post.title = _titleController.text;
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => NewPostDateView(post: post)),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}