import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/views/new_posts/text_view.dart';

class NewPostLocationView extends StatelessWidget {
  NewPostLocationView({Key key, @required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    var _titleController = TextEditingController();
    _titleController.text = post.title;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'CREATE A TEXT POST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Enter a Post Title'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            ElevatedButton(
                
                onPressed: () {
                  post.title = _titleController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPostDateView(post: post)),
                  );
                },child: Text('Continue'),),
          ],
        ),
      ),
    );
  }
}
