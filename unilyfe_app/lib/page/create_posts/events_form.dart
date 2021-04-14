import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/event_post.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int selection = 0;

// ignore: must_be_immutable
class EventForm extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  String _location,_title, _event_date,_information;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'CREATE A EVENT POST',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Name of the event',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _title = value.trim();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Location of the event',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _location = value.trim();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Date of the event mm\dd\yyyy',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _event_date = value.trim();
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Information about the event',
              contentPadding:
                  const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(25.7),
              ),
            ),
            onChanged: (value) {
              _information= value.trim();
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
                print(selection);
                channel = 'SOCIAL';
              }

              final uid = await Provider.of(context).auth.getCurrentUID();
              var doc = db.collection('posts').doc();
              final post = EventPost(doc.id, _title, DateTime.now(), _information,
                  channel, uid, 0, false, {uid: false}, null, null, null);

              post.postid = doc.id;
              post.location = _location;
              post.event_date = _event_date as DateTime;

              await db.collection('userData').doc(uid).get().then((result) {
                post.username = result['username'];
              });

              //DocumentReference channel;
              if (selection == 0) {
                //await db.collection("food_posts").add(post.toJson());
                await db
                    .collection('food_posts')
                    .doc(doc.id)
                    .set(post.toJson());
              } else if (selection == 1) {
                //await db.collection("study_posts").add(post.toJson());
                await db
                    .collection('study_posts')
                    .doc(doc.id)
                    .set(post.toJson());
              } else {
                //await db.collection("social_posts").add(post.toJson());
                await db
                    .collection('social_posts')
                    .doc(doc.id)
                    .set(post.toJson());
              }
              await db.collection('posts').doc(doc.id).set(post.toJson());
              await db
                  .collection('userData')
                  .doc(uid)
                  .collection('event_posts')
                  .doc(doc.id)
                  .set(post.toJson());
              //  Navigator.of(context).popUntil((route) => route.isFirst);
              //  Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pop(context);
              // Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => CreatePage())).then((_) => refresh());
            },
            //   child: Text("Post"),
            //  onPressed: () async{
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
                print('INDEX: $i');
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
