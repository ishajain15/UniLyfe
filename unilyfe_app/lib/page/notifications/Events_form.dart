import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:unilyfe_app/models/event_post.dart';
import 'package:unilyfe_app/page/notifications/local_notifications_helper.dart';
import 'package:unilyfe_app/page/notifications/second_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/models/event_post.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

int selection = 0;
class EventForm extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<EventForm> {
  final notifications = FlutterLocalNotificationsPlugin();
  final db = FirebaseFirestore.instance;
  String _location,_title, _event_date,_information;
  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
      );
  // get_snapshots() async {
  //   var beginningDate = DateTime.now();
  //   var newDate=beginningDate.subtract(Duration(days: 5));
  //   QuerySnapshot qShot = await FirebaseFirestore.instance
  //   .collection('event_posts')
  //   .where('event_date',isGreaterThanOrEqualTo:newDate)
  //   .where('event_date',isLessThanOrEqualTo:beginningDate)
  //   .get().catchError((onError){print(onError);});
  //   var docs = qShot.docs;
  //   for (var i in docs){
  //     print(i.data()['title'].toString());
  //   }
  // }
  @override
  Widget build(BuildContext context){
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
                  channel, uid, 0, false, {uid: false}, null, null, null, null, null);

              post.postid = doc.id;
              post.location = _location;
              DateFormat format = DateFormat("MM/dd/yyyy");
              post.event_date = format.parse(_event_date);
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
              await db
                    .collection('event_posts')
                    .doc(doc.id)
                    .set(post.toJson());
              //  Navigator.of(context).popUntil((route) => route.isFirst);
              //  Navigator.of(context).popUntil((route) => route.isFirst);
              
               var beginningDate = DateTime.now();
    var newDate=beginningDate.add(Duration(days: 1));
    QuerySnapshot qShot = await FirebaseFirestore.instance
    .collection('event_posts')
    .where('event_date',isLessThanOrEqualTo:newDate)
    .where('event_date',isGreaterThanOrEqualTo:beginningDate)
    .get().catchError((onError){print(onError);});
    var docs = qShot.docs;
    String words = '';
    for (var i in docs){
      words += i.data()['title'].toString() + ', ';
    }
    showOngoingNotification(notifications,title: 'Upcoming events 1 day away', body: words);
              // showOngoingNotification(notifications,title: 'Tite', body: 'Body');
              Navigator.pop(context);
              // Navigator.pushReplacement(context,MaterialPageRoute(builder: (_) => CreatePage())).then((_) => refresh());
            },
            child: Text('SUBMIT'),
          ),
        ],
      ),
    );













  // new Container(
  //       padding: EdgeInsets.all(4),
  //       child: ElevatedButton(         
  //         onPressed: () => showOngoingNotification(notifications,
  //                 title: 'Tite', body: 'Body'),
  //         style: ElevatedButton.styleFrom(
  //           primary: Color(0xFFF46C6B),
  //           onPrimary: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10.0)),
  //         ),
  //         child: Text(
  //           'Create a  NotificationButton',
  //           //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //         ),
  //       ),
  //     );
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
