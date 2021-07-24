

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import '../main.dart';

String friendUID = '';

class FriendCards extends StatefulWidget {
  const FriendCards({Key key}) : super(key: key);

  @override
  FriendCardsWidget createState() => FriendCardsWidget();
}

class FriendCardsWidget extends State<FriendCards> {
  String uid = '';
  List<String> myClasses;
  List<String> myHobbies;
  final db = FirebaseFirestore.instance;
  String friendDisplayName = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of(context).auth.getCurrentUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return displayFriends(context);
        } else {
          return buildLoading();
        }
      },
    );
  }

  dynamic getMyClassesAndHobbies(context) async {
    uid = await Provider.of(context).auth.getCurrentUID();
    await db.collection('userData').doc(uid).get().then((result) {
      myClasses = List.from(result['classes']);
      myHobbies = List.from(result['hobbies']);
    });
  }

  Widget displayFriends(context) {
    return Container(
      child: FutureBuilder(
          future: getMyClassesAndHobbies(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Flexible(
                child: StreamBuilder(
                    stream: getFriendsStreamSnapshots(context),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return buildLoading();
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildFriendCard(
                                  context, snapshot.data.docs[index]));
                    }),
              );
            }
            return Container();
            //uid = await Provider.of(context).auth.getCurrentUID();
          }),
    );
  }

  /*Widget _determineImageProfile(String profilePicturePath) {
    //if profile pic exists
    if (profilePicturePath != "\"\"") {
      return Container();
      //if profile pic doesnt exist
    } else {
      return Text(friendDisplayName.displayName[0].toUpperCase(),
          style: TextStyle(
              fontSize: 100, fontWeight: FontWeight.bold, color: Colors.white));
    }
  }*/

  Widget buildFriendCard(BuildContext context, DocumentSnapshot user) {
     if (user['uid'] == uid) {
      return Container();
    }
    Widget circleAvatarChild;
    if (user['profilepicture'] != '\"\"') {
      circleAvatarChild = Container();
    } else {
      circleAvatarChild = Text(user['displayName'][0].toUpperCase(),
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white));
    }
    var friendClasses = List<String>.from(user['classes']);
    var friendHobbies = List<String>.from(user['hobbies']);
    friendUID = user['uid'];
    var sameClasses = <String>[];
    var sameHobbies = <String>[];
    for (var i = 0; i < friendClasses.length; i++) {
      if (myClasses.contains(friendClasses[i])) {
        sameClasses.add(friendClasses[i]);
      }
    }
    for (var i = 0; i < friendHobbies.length; i++) {
      if (myHobbies.contains(friendHobbies[i])) {
        sameHobbies.add(friendHobbies[i]);
      }
    }

    Widget displayNameWidget = Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        user['displayName'].toString(),
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
        user['year'].toString(),
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
        user['bio'].toString(),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Widget alsoLikesWidget = Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        'Also likes:',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    Widget alsoTakesWidget = Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        'Also takes:',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    if (sameClasses.isNotEmpty && sameHobbies.isNotEmpty) {
      return Flex(direction: Axis.horizontal, children: [
        Expanded(
          ///aspectRatio: 4 / 3,
          child: Card(
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
                        alsoLikesWidget,
                        chipList(sameHobbies, const Color(0xFFF46C6B)),
                        alsoTakesWidget,
                        chipList(sameClasses, const Color(0xFFF99E3E)),
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
                            backgroundImage: /*user['profilepicture'] == "\"\""
                                ? AssetImage('assets/empty-profile.png')
                                : */FileImage(File(user['profilepicture'])),
                            backgroundColor:
                                Color(user['color_code']).withOpacity(1.0),
                            child:
                                circleAvatarChild),
                        Container(
                            padding: const EdgeInsets.all(8),
                            //child: addFriendButton(context, friendUID))
                            child: AddFriendButtonWidget())
                      ]),
                ],
              ),
            ),
          ),
        )
      ]);
    } else if (sameClasses.isNotEmpty) {
      return Flex(direction: Axis.horizontal, children: [
        Expanded(
          ///aspectRatio: 4 / 3,
          child: Card(
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
                        alsoTakesWidget,
                        chipList(sameClasses, const Color(0xFFF99E3E)),
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
                            backgroundImage: /*user['profilepicture'] == "\"\""
                                ? AssetImage('assets/empty-profile.png')
                                : */FileImage(File(user['profilepicture'])),
                            backgroundColor:
                                Color(user['color_code']).withOpacity(1.0),
                            child:
                                circleAvatarChild),
                        Container(
                            padding: const EdgeInsets.all(8),
                            //child: addFriendButton(context, friendUID)
                            child: AddFriendButtonWidget())
                      ]),
                ],
              ),
            ),
          ),
        )
      ]);
    } else if (sameHobbies.isNotEmpty) {
      return Flex(direction: Axis.horizontal, children: [
        Expanded(
          ///aspectRatio: 4 / 3,
          child: Card(
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
                        alsoLikesWidget,
                        chipList(sameHobbies, const Color(0xFFF46C6B)),
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
                            backgroundImage: /*user['profilepicture'] == "\"\""
                                ? AssetImage('assets/empty-profile.png')
                                : */FileImage(File(user['profilepicture'])),
                            backgroundColor:
                                Color(user['color_code']).withOpacity(1.0),
                            child:
                                circleAvatarChild),
                        Container(
                            padding: const EdgeInsets.all(8),
                            //child: addFriendButton(context, friendUID)
                            child: AddFriendButtonWidget())
                      ]),
                ],
              ),
            ),
          ),
        )
      ]);
    } else {
      return Flex(direction: Axis.horizontal, children: [
        Expanded(
          ///aspectRatio: 4 / 3,
          child: Card(
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
                      ],
                    ),
                  ),
                  /*3*/
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                AssetImage('assets/empty-profile.png')),*/
                        CircleAvatar(
                            radius: 50.0,
                            backgroundImage: /*user['profilepicture'] == "\"\""
                                ? AssetImage('assets/empty-profile.png')
                                : */FileImage(File(user['profilepicture'])),
                            backgroundColor:
                                Color(user['color_code']).withOpacity(1.0),
                            child:
                                circleAvatarChild),
                        Container(
                            padding: const EdgeInsets.all(8),
                            //child: addFriendButton(context, friendUID)
                            child: AddFriendButtonWidget())
                      ]),
                ],
              ),
            ),
          ),
        )
      ]);
    }
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(0.5),
      label: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

  Widget chipList(List<String> things, Color color) {
    var list = <Widget>[];
    for (var i = 0; i < things.length; i++) {
      list.add(_buildChip(things[i], color));
    }
    Widget chips = Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: Wrap(spacing: 6.0, runSpacing: 6.0, children: list));
    return chips;
  }

  Stream<QuerySnapshot> getFriendsStreamSnapshots(BuildContext context) async* {
    // ignore: unused_local_variable
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('userData').snapshots();

    // .collection("userData")
    // .doc(uid)
    // .collection("posts")
    // .snapshots();
  }

  dynamic addFriendButton(context, String friendUID) {
  }
}

class AddFriendButtonWidget extends StatefulWidget {
  const AddFriendButtonWidget({Key key}) : super(key: key);

  @override
  MyAddFriendButton createState() => MyAddFriendButton();
}

class MyAddFriendButton extends State<AddFriendButtonWidget> {
  final db = FirebaseFirestore.instance;
  bool addFriendBool = true;
  bool addedBool = false;
  String addFriend = 'Add Friend!';
  String added = 'Friend Added!';
  String friendUIDLocal = friendUID;
  var friendsList = [];
  int stateSet = 0;

  dynamic getFriendState() async {
    var uid = await Provider.of(context).auth.getCurrentUID();
    await db
        .collection('userData')
        .doc(uid)
        .collection('friends')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var friend = doc['friendUID'].toString();
        friendsList.add(friend);
      });
    });
    if (friendsList.contains(friendUIDLocal) && stateSet == 0) {
      addFriendBool = false;
      addedBool = true;
    }
    stateSet = 0;
  }

  @override
  Widget build(BuildContext context) {
    //return Container(
    return FutureBuilder(
        future: getFriendState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {}
          return Container(
            padding: EdgeInsets.all(4),
            child: ElevatedButton(
              onPressed: () async {
                var uid = await Provider.of(context).auth.getCurrentUID();
                if (addFriendBool) {
                  await db
                      .collection('userData')
                      .doc(uid)
                      .collection('friends')
                      .doc(friendUIDLocal)
                      .set({'friendUID': friendUIDLocal});
                } else {
                  await db
                      .collection('userData')
                      .doc(uid)
                      .collection('friends')
                      .doc(friendUIDLocal)
                      .delete();
                }
                setState(() {
                  addFriendBool = !addFriendBool;
                  addedBool = !addedBool;
                  stateSet = 1;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFF46C6B),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: Text(addFriendBool ? addFriend : added
                  //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
            ),
          );
        });
  }
}
