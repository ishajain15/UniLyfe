import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/models/poll_post.dart';

int selection = 0;

// ignore: must_be_immutable
class PollForm extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  String _question, _option1, _option2, _option3, _option4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'CREATE A POLL POST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Question',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _question = value.trim();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Option 1',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _option1 = value.trim();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Option 2',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _option2 = value.trim();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Option 3',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _option3 = value.trim();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Option 4',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _option4 = value.trim();
            },
          ),
          MyAppOne(),
          ElevatedButton(
            onPressed: () async {
              var channel = 'Post';
              if (selection == 0) {
                channel = 'FOOD';
              } else if (selection == 1) {
                channel = 'STUDY';
              } else {
                channel = 'SOCIAL';
              }

              final uid = await Provider.of(context).auth.getCurrentUID();
              var doc = db.collection('posts').doc();
              var users = <String, dynamic>{'uid':1};
              final post = PollPost(doc.id, _question, DateTime.now(), _option1,
                  channel, uid, 0, false, {uid: false}, null, null, null, null, users, null);
              post.postid = doc.id;
              dynamic options = [_option1,_option2,_option3,_option4];
              post.options = options;

              await db.collection('userData').doc(uid).get().then((result) {
                post.username = result['username'];
              });

              await db
                    .collection('userData')
                    .doc(uid)
                    .update({'points_field': FieldValue.increment(10)});
                  post.postid = doc.id;

              //DocumentReference channel;
              if (selection == 0) {
                await db
                    .collection('food_posts')
                    .doc(doc.id)
                    .set(post.toJson());
              } else if (selection == 1) {
                await db
                    .collection('study_posts')
                    .doc(doc.id)
                    .set(post.toJson());
              } else {
                await db
                    .collection('social_posts')
                    .doc(doc.id)
                    .set(post.toJson());
              }
              await db.collection('posts').doc(doc.id).set(post.toJson());
              await db
                  .collection('userData')
                  .doc(uid)
                  .collection('poll_posts')
                  .doc(doc.id)
                  .set(post.toJson());
              Navigator.pop(context);
            },
            child: Text('SUBMIT'),
          ),
        ],
      ),
    );
  }
}

class MyAppOne extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppOne> {
  List<bool> isSelected;

  @override
  void initState() {
    // this is for 3 buttons, add "false" same as the number of buttons here
    isSelected = [true, false, false];
    selection = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        // logic for button selection below
        onPressed: (int index) {
          setState(() {
            for (var i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
              if (isSelected[i] == true) {
                selection = i;
              }
            }
          });
        },
        isSelected: isSelected,
        children: <Widget>[
          // first toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'FOOD',
            ),
          ),
          // second toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'STUDY',
            ),
          ),
          // third toggle button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SOCIAL',
            ),
          ),
        ],
      ),
    );
  }
}
