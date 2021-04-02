import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
String reason = '';

// ignore: must_be_immutable
class UserName extends StatefulWidget {
  UserName(
      {Key key,
      @required this.postid,
      @required this.postChannel,
      @required this.username})
      : super(key: key);
  String postid;
  String postChannel;
  String username;
  @override
  UserNameState createState() =>
      UserNameState(postid: postid, postChannel: postChannel, username: username);
}

class UserNameState extends State<UserName> {
  UserNameState(
      {Key key,
      @required this.postid,
      @required this.postChannel,
      @required this.username});
  String postid;
  String postChannel;
  String username;
  //name, display_name, biography, tags
  void bottom_Sheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .60,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF46C6B),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    'HI',
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(username,
            style: TextStyle(
                fontSize: 15,
                color: Color(0xFFF46C6B),
                fontWeight: FontWeight.bold)),
        onPressed: () => bottom_Sheet(context));
  }
}
