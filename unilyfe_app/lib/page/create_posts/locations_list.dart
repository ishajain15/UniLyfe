import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/post.dart';


class LocationListView extends StatelessWidget {
  LocationListView({Key key, @required this.post}) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    //var _titleController = TextEditingController();
    //_titleController.text = post.title;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'CREATE A REVIEW POST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Choose a Location To Review'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                //controller: _titleController,
                autofocus: true,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //post.title = _titleController.text;
                // var postIt = true;

                // if (postIt) {
                //   await Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => NewPostDateView(post: post)),
                //   );
                // }
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
