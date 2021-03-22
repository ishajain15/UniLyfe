import 'package:flutter/material.dart';
import 'package:polls/polls.dart';

import 'package:unilyfe_app/models/global.dart' as global;
class PollView extends StatefulWidget {
  @override
  _PollViewState createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {
  double option1 = 1.0;
  double option2 = 1.0;
  double option3 = 1.0;
  double option4 = 1.0;
  String user = 'king@mail.com';
  Map usersWhoVoted = {'sam@mail.com': 3, 'mike@mail.com' : 4, 'john@mail.com' : 1, 'kenny@mail.com' : 1};
  String creator = 'eddy@mail.com';

  @override
  Widget build(BuildContext context) {
    if(global.question == ''){

       return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("This post doesn't have a poll"),
        ElevatedButton(
                onPressed: (){
                  Navigator.of(context).popUntil((route) => route.isFirst);
              },
               child: Text('Go back'),
            ),
      ],
        ),
      );
    }else{
        return Scaffold(
          body: Container(
           child: Column(
            children: <Widget>[
              Padding(
            padding: const EdgeInsets.only(top:300,right: 20, left:20),
    
            child:Align (alignment: Alignment(1, 0.5),
              child: Polls(
                children: [
                  // This cannot be less than 2, else will throw an exception
              Polls.options(title: global.option1, value: option1),
              Polls.options(title: global.option2, value: option2),
              Polls.options(title: global.option3, value: option3),
              Polls.options(title: global.option4, value: option4),
            ], question: Text(global.question),
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
          ),
          
        )
        
      ),
       ElevatedButton(
                onPressed: (){
                  global.question = '';
                  global.option1 = '';
                  global.option2 = '';
                  global.option3 = '';
                  global.option4 = '';
                  Navigator.of(context).popUntil((route) => route.isFirst);
              },
               child: Text('Go back'),
            ),
            ],
      
      ),
          ),
    );
    }
  }
}

