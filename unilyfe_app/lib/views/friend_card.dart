

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:unilyfe_app/customized_items/buttons/add_friend_button.dart';
import 'package:unilyfe_app/customized_items/buttons/photo_posting_button.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import '../demo_values.dart';
import '../main.dart';

String friendUID = "";

class FriendCards extends StatefulWidget {
  const FriendCards({Key key}) : super(key: key);

  @override
  FriendCardsWidget createState() => FriendCardsWidget();
}

class FriendCardsWidget extends State<FriendCards> {
  String uid = "";
  List<String> myClasses;
  List<String> myHobbies;
  final db = FirebaseFirestore.instance;
  String friendDisplayName = "";

  @override
  Widget build(BuildContext context) {
    /*FutureBuilder(
      future: Provider.of(context).auth.getCurrentUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return setUID(context);
        } else {
          return buildLoading();
        }
      },
    );
    return Flexible(
      child: StreamBuilder(
          stream: getFriendsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return buildLoading();
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildFriendCard(context, snapshot.data.docs[index]));
          }),
    );*/
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

  getMyClassesAndHobbies(context) async {
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

  @override
  Widget buildFriendCard(BuildContext context, DocumentSnapshot user) {
    Widget circleAvatarChild;
    if (user['profilepicture'] != "\"\"") {
      circleAvatarChild = Container();
    } else {
      circleAvatarChild = Text(user['displayName'][0].toUpperCase(),
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white));
    }
    List<String> friendClasses = List.from(user['classes']);
    List<String> friendHobbies = List.from(user['hobbies']);
    friendUID = user['uid'];
    List<String> sameClasses = [];
    List<String> sameHobbies = [];
    for (int i = 0; i < friendClasses.length; i++) {
      if (myClasses.contains(friendClasses[i])) {
        sameClasses.add(friendClasses[i]);
      }
    }
    for (int i = 0; i < friendHobbies.length; i++) {
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
    if (sameClasses.length > 0 && sameHobbies.length > 0) {
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
                            child: addFriendButtonWidget())
                      ]),
                ],
              ),
            ),
          ),
        )
      ]);
    } else if (sameClasses.length > 0) {
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
                            child: addFriendButtonWidget())
                      ]),
                ],
              ),
            ),
          ),
        )
      ]);
    } else if (sameHobbies.length > 0) {
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
                            child: addFriendButtonWidget())
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
                            child: addFriendButtonWidget())
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

  addFriendButton(context, String friendUID) {
    //String addFriend = 'Add Friend!';
    //String added = 'Added!';
    //bool addFriendBool = false;
    //bool addedBool = true;

    /*return Container(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () async {
          print(friendUID);
          print(uid);
          await db
              .collection('userData')
              .doc(uid)
              .collection('friends')
              .doc(friendUID)
              .set({'friendUID': friendUID});
          setState(() {
            addFriendBool = !addFriendBool;
            print("addFriendBool: " + addFriendBool.toString());
            addedBool = !addedBool;
            print("addedBool: " + addedBool.toString());
            //print('on press: the randomized button has been clicked');
          });
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFF46C6B),
          onPrimary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        child: Text(addFriendBool ? addFriend : added
            //style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
      ),
    );*/
  }
}

class addFriendButtonWidget extends StatefulWidget {
  const addFriendButtonWidget({Key key}) : super(key: key);

  @override
  myAddFriendButton createState() => myAddFriendButton();
}

class myAddFriendButton extends State<addFriendButtonWidget> {
  final db = FirebaseFirestore.instance;
  bool addFriendBool = true;
  bool addedBool = false;
  String addFriend = 'Add Friend!';
  String added = 'Friend Added!';
  String friendUIDLocal = friendUID;
  var friendsList = [];
  int stateSet = 0;

  /*
        FutureBuilder(
          future: Provider.of(context).auth.getCurrentUID(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _displayClasses(context, snapshot);
            } else {
              return buildLoading();
            }
          },
        ),
  */

  getFriendState() async {
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
        friendsList.add(friend);
      });
    });
    if (friendsList.contains(friendUIDLocal) && stateSet == 0) {
      //print(friendUIDLocal);
      //addFriendBool = !addFriendBool;
      //addedBool = !addedBool;
      addFriendBool = false;
      addedBool = true;
    }
    stateSet = 0;
  }

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
                String uid = await Provider.of(context).auth.getCurrentUID();
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
                  // print("addFriendBool: " + addFriendBool.toString());
                  addedBool = !addedBool;
                  stateSet = 1;
                  // print("addedBool: " + addedBool.toString());
                  //print('on press: the randomized button has been clicked');
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
