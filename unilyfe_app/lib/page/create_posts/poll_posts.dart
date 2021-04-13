import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';

class DisplayPosts extends StatefulWidget {
  DisplayPosts({Key key, @required this.options, @required this.title}) : super(key: key);
  String postid;
  int likes;
  String postChannel;
  dynamic map_liked;
  String uid;
  dynamic options;
  String title;
  @override
  Posts createState() => Posts(options:options, title:title);
} // end of DiplayPosts

class Posts extends State<DisplayPosts> {
  Posts({
    Key key,
    @required this.options, @required this.title
  });
  double option1 = 1.0;
  double option2 = 1.0;
  double option3 = 1.0;
  double option4 = 1.0;
  dynamic options;
  String title;
  Map usersWhoVoted = {
    'sam@mail.com': 3,
    'mike@mail.com': 4,
    'john@mail.com': 1,
    'kenny@mail.com': 1
  };
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
      voteData: usersWhoVoted,
      userChoice: usersWhoVoted[user],
      onVoteBackgroundColor: Color(0xFFF56D6B),
      leadingBackgroundColor: Color(0xFFF56D6B),
      backgroundColor: Colors.white,
      onVote: (choice) {
        print(choice);
        setState(() {
          usersWhoVoted[user] = choice;
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
