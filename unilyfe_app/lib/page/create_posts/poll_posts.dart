import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

// ignore: must_be_immutable
class DisplayPosts extends StatefulWidget {
  DisplayPosts({Key key, @required this.options, @required this.title, @required this.postid, @required this.users, location}) : super(key: key);
  String postid;
  int likes;
  String postChannel;
  dynamic map_liked;
  String uid;
  dynamic options;
  String title;
  Map<String, dynamic> users;
  @override
  Posts createState() => Posts(options:options, title:title, postid:postid, users: users);
} // end of DiplayPosts

class Posts extends State<DisplayPosts> {
  Posts({
    Key key,
    @required this.options, @required this.title, @required this.postid, @required this.users
  });
  double option1 = 1.0;
  double option2 = 1.0;
  double option3 = 1.0;
  double option4 = 1.0;
  dynamic options;
  String postid;
  String title;
 Map<String, dynamic> users;
  
  String creator = 'eddy@mail.com';
  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser.uid;
    return Polls(
      children: [
        // This cannot be less than 2, else will throw an exception
        Polls.options(title: options[0], value: option1),
        Polls.options(title: options[1], value: option2),
        Polls.options(title: options[2], value: option3),
        Polls.options(title: options[3], value: option4),
      ],
      question: Text(title),
      currentUser: user,
      creatorID: creator,
      voteData: users,
      userChoice: users[user],
      onVoteBackgroundColor: Color(0xFFF56D6B),
      leadingBackgroundColor: Color(0xFFF56D6B),
      backgroundColor: Colors.white,
      onVote: (choice) {
        setState(() {
          Provider.of(context)
          .db
          .collection('posts')
          .doc(postid)
          .update({'users.$user': choice});
          users[user] = choice;
        });
        if (choice == 1) {
          setState(() {
            option1 += 1.0;
          });
        }
        if (choice == 2) {
          setState(() {
            option2 += 1.0;
          });
        }
        if (choice == 3) {
          setState(() {
            option3 += 1.0;
          });
        }
        if (choice == 4) {
          setState(() {
            option4 += 1.0;
          });
        }
      },
      
    );
  }
} // end of posts
