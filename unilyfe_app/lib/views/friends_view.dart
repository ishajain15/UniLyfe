import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:unilyfe_app/models/User.dart';

// ignore: must_be_immutable
class FriendsView extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  var friendsUIDs = [];
  List<Widget> friends = [];
  List years = [];
  List displayNames = [];
  List bios = [];
  User user = User('', '', '', '', [], [], 0, 0);
  List profilePicturePaths = [];
  List color_codes = [];

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getFriendUIDs(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {}

          for (var i = 0; i < friendsUIDs.length; i++) {
            if (friends.length < friendsUIDs.length) {
              friends.add(buildFriendCard(context, friendsUIDs[i], i));
            }
          }
          return Scaffold(body: ListView(children: friends));
        });
  }

  dynamic getFriendUIDs(context) async {
    friendsUIDs = [];
    var uid = await Provider.of(context).auth.getCurrentUID();
    await db
        .collection('userData')
        .doc(uid)
        .collection('friends')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var friend = doc['friendUID'].toString();
        friendsUIDs.add(friend);
      });
    });
  }

  dynamic getFriendData(context, String friendUID) async {
    await db.collection('userData').doc(friendUID).get().then((result) {
      years.add(result['year'].toString());
      displayNames.add(result['displayName'].toString());
      bios.add(result['bio'].toString());
      profilePicturePaths.add(result['profilepicture'].toString());
      color_codes.add(result['color_code']);
    });
  }

  Widget buildFriendCard(BuildContext context, String friendUID, int i) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: getFriendData(context, friendUID),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {}
            Widget circleAvatarChild;
            if (profilePicturePaths[i] != '\"\"') {
              circleAvatarChild = Container();
            } else {
              circleAvatarChild = Text(displayNames[i][0].toUpperCase(),
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white));
            }
            Widget displayNameWidget = Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
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
                              backgroundImage: FileImage(File(profilePicturePaths[i])),
                              backgroundColor:
                                  Color(color_codes[i]).withOpacity(1.0),
                              child: circleAvatarChild),
                        ]),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
