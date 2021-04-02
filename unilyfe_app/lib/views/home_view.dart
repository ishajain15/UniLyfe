// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/comment_button.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_all.dart';
import 'package:unilyfe_app/page/report_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:unilyfe_app/page/likes_page.dart';
import 'package:polls/polls.dart';

import 'package:unilyfe_app/models/global.dart' as global;

//bool hasBeenPressed = false;

class HomeViewState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeView();
}

//class Posts extends State<DisplayPosts> {
class HomeView extends State<HomeViewState> {
  @override
  bool hasBeenPressed = false;

  Widget build(BuildContext context) {
    //print("rebuilding!");
    //print(hasBeenPressed);
    return Container(
      child: Column(
        children: [
          InformationButtonAll(),
          //RandomizePage(),
          buildRandomizeButton(),
          //RevertPage(),
          buildRevertButton(),
          Flexible(
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
        ],
      ),
    );
  }

  Stream<QuerySnapshot> getUserPostsStreamSnapshots(
      BuildContext context) async* {
    // ignore: unused_local_variable
    final uid = await Provider.of(context).auth.getCurrentUID();

    // the user clicked the "randomized" button
    if (hasBeenPressed == true) {
      print('randomize SHOULDVE been clicked!');
      yield* FirebaseFirestore.instance.collection('posts').snapshots();
    } else {
      yield* FirebaseFirestore.instance
          .collection('posts')
          .orderBy('time', descending: true)
          .snapshots();
    }

    // the user clicked the "revert" button
    if (hasBeenPressed == false) {
      print('revert SHOULDVE been clicked!');
      yield* FirebaseFirestore.instance
          .collection('posts')
          .orderBy('time', descending: true)
          .snapshots();
    }

    // .collection("userData")
    // .doc(uid)
    // .collection("posts")
    // .snapshots();
  }

  // Randomizing Posts
  onPressed() {
    setState(() {
      hasBeenPressed = !hasBeenPressed;
      //print('on press: the randomized button has been clicked');
    });
  }

  Widget buildRandomizeButton() {
    Alignment.topLeft;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFF46C6B),
        onPrimary: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      onPressed: onPressed,
      child: Text(
        'Randomize Posts',
      ),
    );
  }

  // Reverting Posts
  onPressed_2() {
    setState(() {
      hasBeenPressed = !hasBeenPressed;
      //print('on press: the revert button has been clicked');
    });
  }

  Widget buildRevertButton() {
    Alignment.topLeft;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFF46C6B),
        onPrimary: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      onPressed: onPressed_2,
      child: Text(
        'Revert Changes',
      ),
    );
  }

  Widget buildPostCard(BuildContext context, DocumentSnapshot post) {
    if (post['postType'] == 0) {
      return Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                   child: Row(
                    children: <Widget>[
                      Text(post['username'], style: TextStyle(fontSize: 15, color: Color(0xFFF46C6B), fontWeight: FontWeight.bold) ), Spacer(),
                    ],
                  ),
                  //child: Text(post['username'], style: TextStyle(fontSize: 20) ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Text(
                          "Title: ${(post['title'] == null) ? "n/a" : post['title']}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Spacer(),
                      Report(
                          postid: post['postid'],
                          postChannel: post['postChannel']),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "Date posted: ${DateFormat('MM/dd/yyyy (h:mm a)').format(post['time'].toDate()).toString()}"),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Text(
                            "Text: ${(post['text'] == null) ? "n/a" : post['text']}"),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Post channel: ${post['postChannel']}"),
                      Spacer(),
                      // ViewInfoButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Likes(
                          postid: post['postid'],
                          title: post['title'],
                          time: post['time'].toDate(),
                          text: post['text'],
                          likes: post['likes'],
                          liked: post['liked'],
                          postChannel: post['postChannel'],
                          map_liked: post['map_liked'],
                          uid: post['uid'],
                          username: post['username']),
                      CommentButtonWidget(
                        postid: post['postid'],
                      ),
                      SmoothStarRating()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[Text("Likes: ${post['likes']}")],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                   child: Row(
                    children: <Widget>[
                      Text(post['username'], style: TextStyle(fontSize: 15, color: Color(0xFFF46C6B), fontWeight: FontWeight.bold) ), Spacer(),
                    ],
                  ),
                  //child: Text(post['username'], style: TextStyle(fontSize: 20) ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Text(
                          "Title: ${(post['title'] == null) ? "n/a" : post['title']}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Spacer(),
                      Report(
                          postid: post['postid'],
                          postChannel: post['postChannel']),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(flex: 15, child: DisplayPosts()),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "Date posted: ${DateFormat('MM/dd/yyyy (h:mm a)').format(post['time'].toDate()).toString()}"),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Text(
                            "Text: ${(post['text'] == null) ? "n/a" : post['text']}"),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Post channel: ${post['postChannel']}"),
                      Spacer(),
                      // ViewInfoButton(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Likes(
                          postid: post['postid'],
                          likes: post['likes'],
                          postChannel: post['postChannel'],
                          map_liked: post['map_liked'],
                          uid: post['uid'],
                          username: post['username']),
                      CommentButtonWidget(
                        postid: post['postid'],
                      ),
                      SmoothStarRating()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[Text("Likes: ${post['likes']}")],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
} // end of HomeView

// ignore: must_be_immutable
class DisplayPosts extends StatefulWidget {
  DisplayPosts({Key key}) : super(key: key);
  String postid;
  int likes;
  String postChannel;
  dynamic map_liked;
  String uid;
  @override
  Posts createState() => Posts();
} // end of DiplayPosts

class Posts extends State<DisplayPosts> {
  Posts();
  double option1 = 1.0;
  double option2 = 1.0;
  double option3 = 1.0;
  double option4 = 1.0;
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
        Polls.options(title: 'option a', value: option1),
        Polls.options(title: 'option b', value: option2),
        Polls.options(title: 'option c', value: option3),
        Polls.options(title: 'option d', value: option4),
      ],
      question: Text(global.question),
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
