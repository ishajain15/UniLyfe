// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/comment_button.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_all.dart';
import 'package:unilyfe_app/customized_items/buttons/randomize_page.dart';
import 'package:unilyfe_app/customized_items/buttons/revert.dart';
import 'package:unilyfe_app/page/report_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:unilyfe_app/page/likes_page.dart';
import 'package:polls/polls.dart';

import 'package:unilyfe_app/models/global.dart' as global;

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InformationButtonAll(),
          RandomizePage(),
          RevertPage(),
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
      yield* FirebaseFirestore.instance
          .collection('posts')
          .orderBy('time', descending: true)
          .snapshots();
      if (RandomizePage().randomizing_criteria() == true) {
          print('randomize SHOULDVE been clicked!');
          yield* FirebaseFirestore.instance
            .collection('posts')
            .snapshots();
      }
      if (RevertPage().revert_criteria() == true) {
          print('revert SHOULDVE been clicked');
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
                          uid: post['uid']),
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
                          uid: post['uid']),
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
}

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
}

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
        Polls.options(title: 'hi', value: option1),
        Polls.options(title: 'bye', value: option2),
        Polls.options(title: 'hi', value: option3),
        Polls.options(title: 'si', value: option4),
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
}
