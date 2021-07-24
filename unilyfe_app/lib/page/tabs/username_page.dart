import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/loaders/color_loader_4.dart';
import 'package:unilyfe_app/customized_items/loaders/dot_type.dart';
import 'package:unilyfe_app/models/User.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

// ignore: must_be_immutable
String reason = '';

// ignore: must_be_immutable
class UserName extends StatefulWidget {
  UserName(
      {Key key,
      @required this.postid,
      @required this.uid,
      @required this.username})
      : super(key: key);
  String postid;
  String uid;
  String username;
  @override
  UserNameState createState() =>
      UserNameState(postid: postid, uid: uid, username: username);
}

class UserNameState extends State<UserName> {
  UserNameState(
      {Key key,
      @required this.postid,
      @required this.uid,
      @required this.username});
  String postid;
  String uid;
  String username;
  final db = FirebaseFirestore.instance;
  User user = User('', '', '', '', [], [], 0, 0);
  //name, display_name, biography, tags
  void bottom_Sheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Column(
              children: <Widget>[
                FutureBuilder(
                  future: Provider.of(context).auth.getCurrentUID(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return displayUserData(context, snapshot);
                    } else {
                      return buildLoading();
                    }
                  },
                ),
                // ),
              ],
            ),
          );
        });
  }

  dynamic getUserData() async {
    await db.collection('userData').doc(uid).get().then((result) {
      //user.username = result['username'].toString();
      user.displayName = result['displayName'].toString();
      user.bio = result['bio'].toString();
      user.year = result['year'].toString();
      user.classes = List.from(result['classes']);
      user.hobbies = List.from(result['hobbies']);
      user.points = result['points_field'];
    });
  }

 dynamic displayUserData(context, snapshot) {
    return Column(children: <Widget>[
      FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {}
            return Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        user.displayName,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        user.year,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        user.bio,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        chipList(user.hobbies, const Color(0xFFF56D6B)),
                        chipList(user.classes, const Color(0xFFF99E3E))
                      ],
                    )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        'Points: ' + user.points.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                  ],
                ));
          })
    ]);
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
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
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Wrap(spacing: 6.0, runSpacing: 6.0, children: list));
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(50, 30),
        ),
        onPressed: () => bottom_Sheet(context),
        child: Text(username,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFFF46C6B),
                fontWeight: FontWeight.bold)));
  }
}

Widget buildLoading() => Center(
        child: ColorLoader4(
      dotOneColor: Color(0xFFF46C6B),
      dotTwoColor: Color(0xFFF47C54),
      dotThreeColor: Color(0xFFFCAC54),
      dotType: DotType.square,
      duration: Duration(milliseconds: 1200),
    ));
