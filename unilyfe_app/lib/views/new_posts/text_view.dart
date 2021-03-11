import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';
import 'package:unilyfe_app/views/new_posts/submit_view.dart';

class NewPostDateView extends StatelessWidget {
  final Post post;
  NewPostDateView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController();
    _textController.text = post.text;

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
            SizedBox(
              height: 10,
            ),
            Text(
              'Title: ${post.title}',
            ),
            SizedBox(
              height: 10,
            ),
            Text('\nEnter Text'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _textController,
                autofocus: true,
              ),
            ),
            ElevatedButton(
                child: Text("Continue"),
                onPressed: () {
                  post.time = DateTime.now();
                  post.text = _textController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPostBudgetView(post: post)),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
