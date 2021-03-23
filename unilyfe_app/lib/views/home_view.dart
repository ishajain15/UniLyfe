// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/comment_button.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_all.dart';
import 'package:unilyfe_app/customized_items/buttons/view_info_button.dart';
import 'package:unilyfe_app/page/report_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:unilyfe_app/page/likes_page.dart';
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InformationButtonAll(),
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
    // .collection("userData")
    // .doc(uid)
    // .collection("posts")
    // .snapshots();
  }

  Widget buildPostCard(BuildContext context, DocumentSnapshot post) {
    //if (post['postType'] == 0) print("TEXT POST");

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
                    Report(postid: post['postid'], postChannel: post['postChannel']),
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
                    ViewInfoButton(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Likes(postid: post['postid'], likes: post['likes'], postChannel: post['postChannel'], map_liked: post['map_liked'], uid:post['uid']),
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
                    children: <Widget>[
                      Text("Likes: ${post['likes']}")
                    ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


