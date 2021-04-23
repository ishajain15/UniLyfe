import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/comment_button.dart';
import 'package:unilyfe_app/customized_items/buttons/garbage_button.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_all.dart';
import 'package:unilyfe_app/customized_items/loaders/color_loader_4.dart';
import 'package:unilyfe_app/customized_items/loaders/dot_type.dart';
import 'package:unilyfe_app/page/create_posts/poll_posts.dart';
import 'package:unilyfe_app/page/report_page.dart';
import 'package:unilyfe_app/page/tabs/username_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:unilyfe_app/page/likes_page.dart';

class HomeViewState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeView();
}

//class Posts extends State<DisplayPosts> {
class HomeView extends State<HomeViewState> {
  @override
  bool hasBeenPressed = false;

  //var location;

  Widget build(BuildContext context) {
    //print("rebuilding!");
    //print(hasBeenPressed);
    return Container(
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Spacer(),
              //RandomizePage(),
              buildRandomizeButton(),
              Spacer(),
              //RevertPage(),
              buildRevertButton(),
              Spacer(),
              InformationButtonAll(),
              Spacer(),
            ],
          ),
          Flexible(
            child: StreamBuilder(
                stream: getUserPostsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return buildLoading();
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
    // getDocuments();
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
                      UserName(
                          postid: post['postid'],
                          uid: post['uid'],
                          username: post['username'])
                    ],
                  ),
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
                          postChannel: post['postChannel'],
                          reported: post['reported']),
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
                            "Text: ${(post['text'] == null) ? "n/a" : post['text']}\nLocation: ${(post['location'] == null) ? "n/a" : post['location']}"),
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
                          username: post['username'],
                          location: post['location']),
                      Spacer(),
                      Visibility(
                        visible: FirebaseAuth.instance.currentUser.uid ==
                            post['uid'],
                        child: GarbageButtonWidget(
                          postid: post['postid'],
                          postChannel: post['postChannel'],
                        ),
                      ),
                      Spacer(),
                      CommentButtonWidget(
                        postid: post['postid'],
                      ),
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
    } else if (post['postType'] == 1) {
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
                      Text(post['username'],
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFF46C6B),
                              fontWeight: FontWeight.bold)),
                      Spacer(),
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
                          postChannel: post['postChannel'],
                          reported: post['reported']),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 15,
                          child: DisplayPosts(
                            options: post['options'],
                            title: post['title'],
                            postid: post['postid'],
                            users: post['users'],
                          )),
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
                            "Text: ${(post['text'] == null) ? "n/a" : post['text']}\nLocation: ${(post['location'] == null) ? "n/a" : post['location']}"),
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
                      Spacer(),
                      Visibility(
                        visible: FirebaseAuth.instance.currentUser.uid ==
                            post['uid'],
                        child: GarbageButtonWidget(
                          postid: post['postid'],
                          postChannel: post['postChannel'],
                        ),
                      ),
                      Spacer(),
                      CommentButtonWidget(
                        postid: post['postid'],
                      ),
                      //SmoothStarRating()
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
    } else if (post['postType'] == 2) {
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
                      UserName(
                          postid: post['postid'],
                          uid: post['uid'],
                          username: post['username'])
                    ],
                  ),
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
                          postChannel: post['postChannel'],
                          reported: post['reported']),
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
                            "Text: ${(post['text'] == null) ? "n/a" : post['text']}\nLocation: ${(post['location'] == null) ? "n/a" : post['location']}"),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "Location: ${(post['location'] == null) ? "n/a" : post['location']}"),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "Event Date: ${DateFormat('MM/dd/yyyy (h:mm a)').format(post['event_date'].toDate()).toString()}"),
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
                          username: post['username'],
                          location: post['location']),
                      Spacer(),
                      Visibility(
                        visible: FirebaseAuth.instance.currentUser.uid ==
                            post['uid'],
                        child: GarbageButtonWidget(
                          postid: post['postid'],
                          postChannel: post['postChannel'],
                        ),
                      ),
                      Spacer(),
                      CommentButtonWidget(
                        postid: post['postid'],
                      ),
                      //SmoothStarRating()
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
    } else if (post['postType'] == 3) {
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
                      UserName(
                          postid: post['postid'],
                          uid: post['uid'],
                          username: post['username'])
                    ],
                  ),
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
                          postChannel: post['postChannel'],
                          reported: post['reported']),
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
                            "Text: ${(post['text'] == null) ? "n/a" : post['text']}\nLocation: ${(post['location'] == null) ? "n/a" : post['location']}"),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200.0,
                    child: Center(
                        child: post['photopath'] == null
                            ? Text('No Image is picked')
                            //: (Image.file(post['photopath'])),
                            //: AssetImage((post['photopath'])),
                            : Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(1),
                                        BlendMode.dstATop),
                                    image: AssetImage(
                                        (post['photopath'])),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                //   child: Row(
                //     children: <Widget>[
                //       Text(
                //           ""),
                //       Spacer(),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                //   child: Row(
                //     children: <Widget>[
                //       Text(
                //           "Event Date:"),
                //       Spacer(),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Post channel: ${post['postChannel']}"),
                      Spacer(),
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
                          username: post['username'],
                          location: post['location']),
                      Spacer(),
                      Visibility(
                        visible: FirebaseAuth.instance.currentUser.uid ==
                            post['uid'],
                        child: GarbageButtonWidget(
                          postid: post['postid'],
                          postChannel: post['postChannel'],
                        ),
                      ),
                      Spacer(),
                      CommentButtonWidget(
                        postid: post['postid'],
                      ),
                      //SmoothStarRating()
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

Widget buildLoading() => Center(
        child: ColorLoader4(
      dotOneColor: Color(0xFFF46C6B),
      dotTwoColor: Color(0xFFF47C54),
      dotThreeColor: Color(0xFFFCAC54),
      dotType: DotType.square,
      duration: Duration(milliseconds: 1200),
    ));
