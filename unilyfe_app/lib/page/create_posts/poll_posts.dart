import 'package:flutter/material.dart';
import 'package:polls/polls.dart';
import 'dart:async';
class PollView extends StatefulWidget {
  @override
  _PollViewState createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {

  double option1 = 2.0;
  double option2 = 0.0;
  double option3 = 2.0;
  double option4 = 3.0;

  String user = "king@mail.com";
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = "eddy@mail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Padding(
        padding: const EdgeInsets.only(top:300,right: 20, left:20),

        child:Align (alignment: Alignment(1, 0.5),
          child: Polls(
            children: [
              // This cannot be less than 2, else will throw an exception
              Polls.options(title: 'Cairo', value: option1),
              Polls.options(title: 'Mecca', value: option2),
              Polls.options(title: 'Denmark', value: option3),
              Polls.options(title: 'Mogadishu', value: option4),
            ], question: Text('how old are you?'),
            currentUser: this.user,
            creatorID: this.creator,
            voteData: usersWhoVoted,
            userChoice: usersWhoVoted[this.user],
            onVoteBackgroundColor: Color(0xFFF56D6B),
            leadingBackgroundColor: Color(0xFFF56D6B),
            backgroundColor: Colors.white,
            onVote: (choice) {
              print(choice);
              setState(() {
                this.usersWhoVoted[this.user] = choice;
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
          ),
        )
      ),
      ),
    );
  }
}
