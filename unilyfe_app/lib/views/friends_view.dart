import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/comments_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
//import 'package:unilyfe_app/models/User.dart';



class FriendsView extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  var friendsUIDs = [];
  // User user = User('', '', '', '', [], [], 0);
  List<Widget> friends = [];
  List years = [];
  List displayNames = [];
  List bios = [];

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Flexible(
              child: StreamBuilder(
                  stream: getUserPostsStreamSnapshots(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return const Text('Loading...');
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildPostCard(context, snapshot.data.docs[index]));
                  }),
            ),
          ),
        ],
      ),
    );*/
    
    return FutureBuilder(
        future: getFriendUIDs(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {}

          for (int i = 0; i < friendsUIDs.length; i++) {
            if (friends.length < friendsUIDs.length) {
              friends.add(buildFriendCard(context, friendsUIDs[i], i));
            }
          }
          return Scaffold(body: ListView(children: friends));
        });
  }

  getFriendUIDs(context) async {
    friendsUIDs = [];
    String uid = await Provider.of(context).auth.getCurrentUID();
    await db
        .collection('userData')
        .doc(uid)
        .collection('friends')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //titlesList[index] = (Text(doc['title'].toString()));
        var friend = doc['friendUID'].toString();
        //titlesList.add(doc['title'].toString());
        friendsUIDs.add(friend);
      });
    });
  }

  getFriendData(context, String friendUID) async {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection('userData').doc(friendUID).get().then((result) {
      //year = result['year'].toString();
      years.add(result['year'].toString());
      //displayName = result['displayName'].toString();
      displayNames.add(result['displayName'].toString());
      //bio = result['bio'].toString();
      bios.add(result['bio'].toString());
    });
  }

  /*Stream<QuerySnapshot> getUserPostsStreamSnapshots(
      BuildContext context) async* {
    // ignore: unused_local_variable
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('userData')
        .doc(uid)
        .collection('comment_history')
        .orderBy('time', descending: true)
        .snapshots();
  }*/

  /*Widget buildPostCard(BuildContext context, DocumentSnapshot comment) {
    return Column(children: <Widget>[
      ListTile(
        dense: true,
        title: Text(comment['comment'] + '\n'),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage('assets/empty-profile.png'),
        ),
        subtitle: Text(DateFormat('MM/dd/yyyy (h:mm a)')
            .format(comment['time'].toDate())
            .toString()),
      ),
      Divider(),
    ]);
  }*/

  Widget buildFriendCard(BuildContext context, String friendUID, int i) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: getFriendData(context, friendUID),
          // ignore: missing_return
          builder: (context, snapshot) {
            //print('points: ' + user.points.toString());
            if (snapshot.connectionState == ConnectionState.done) {}
            Widget displayNameWidget = Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                //displayName.toString(),
                displayNames[i],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
            );

            Widget yearWidget = Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                //year.toString(),
                years[i],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
            );

            Widget bioWidget = Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                //bio.toString(),
                bios[i],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                ),
              ),
            );

            //Widget friendCard = Card(
            return Card(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          displayNameWidget,
                          yearWidget,
                          bioWidget,
                          //alsoLikesWidget,
                          //chipList(sameHobbies, const Color(0xFFF46C6B)),
                        ],
                      ),
                    ),
                    /*3*/
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  AssetImage('assets/empty-profile.png')),
                        ]),
                  ],
                ),
              ),
            );
            //friends.add(friendCard);
            //print("ADDED!");
            // }
          },
        ),
      ],
    );
  }
}
