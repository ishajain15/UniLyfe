import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/global.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/models/poll_post.dart';
import 'package:unilyfe_app/models/global.dart' as global;
class PollForm extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  String _question, _option1,_option2,_option3,_option4;
  Widget build(BuildContext context) {
  return new Scaffold(
    body: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Question',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_question = value.trim();},
        ),
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 1',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option1 = value.trim();},
        ),
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 2',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option2 = value.trim();},
        ),
        new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 3',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option3 = value.trim();},
        ),
         new TextField(
            decoration: new InputDecoration(
                hintText: 'Option 4',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(25.7),
            ),
            ),
            onChanged: (value) {_option4 = value.trim();},
        ),
        ElevatedButton(
            //   child: Text("Post"),
            //  onPressed: () async{
               child: Text("SUBMIT"),
                onPressed: () async {
                 final uid = await Provider.of(context).auth.getCurrentUID();
                //  final PollPost post = new PollPost(_question, DateTime.now(), _option1, true, "Food", uid);
                 final PollPost post = new PollPost(_question, DateTime.now(), _option1,"Food", uid, 0,false);
                  global.question = _question;
                  global.option1 = _option1;
                  global.option2 = _option2;
                   global.option3 = _option3;
                    global.option4 = _option4;
                  await db.collection('posts').add(post.toJson());
                  await db
                      .collection("userData")
                      .doc(uid)
                      .collection("poll_posts")
                      .add(post.toJson());
                  //  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
      ],
    ),
    
  );
}
}