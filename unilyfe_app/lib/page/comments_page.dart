import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:unilyfe_app/customized_items/custom_warning.dart';
import 'package:unilyfe_app/customized_items/loaders/color_loader_4.dart';
import 'package:unilyfe_app/customized_items/loaders/dot_type.dart';
import 'package:unilyfe_app/page/tabs/username_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final commentsRef = FirebaseFirestore.instance.collection('comments');
final db = FirebaseFirestore.instance;
bool replying = false;
String replyTo = 'replying to';
var focusNode = FocusNode();
TextEditingController commentController = TextEditingController();

String censorBadWords(String badString) {
  final filter = ProfanityFilter();
  //Censor the string - returns a 'cleaned' string.
  var cleanString = filter.censor(badString);
  return cleanString;
}

class CommentsPage extends StatefulWidget {
  CommentsPage(
      {this.postid,
      this.uid,
      this.username,
      this.color_code,
      this.displayName,
      this.picturepath});
  final String postid;
  final String uid;
  final String username;
  final int color_code;
  final String displayName;
  final String picturepath;
  @override
  CommentsPageState createState() => CommentsPageState(
        postid: postid,
        uid: uid,
        username: username,
        color_code: color_code,
        displayName: displayName,
        picturepath: picturepath,
      );
}

class CommentsPageState extends State<CommentsPage> {
  CommentsPageState(
      {this.postid,
      this.uid,
      this.username,
      this.color_code,
      this.displayName,
      this.picturepath,});

  final String postid;
  final String uid;
  final String username;
  final int color_code;
  final String displayName;
  final String picturepath;

  StreamBuilder<QuerySnapshot> buildComments() {
    return StreamBuilder(
      stream: commentsRef
          .doc(postid)
          .collection('comments')
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return buildLoading();
        }
        var comments = <Comment>[];
        snapshot.data.docs.forEach((doc) {
          comments.add(Comment.fromDocument(doc));
        });
        return ListView(
          children: comments,
        );
      },
    );
  }

  // ignore: always_declare_return_types
  addComment() async {
    final filter = ProfanityFilter();
    var hasProfanity = filter.hasProfanity(commentController.text);
    var postIt = true;

    if (hasProfanity) {
      postIt = false;
      //Get the profanity used - returns a List<String>
      var wordsFound = filter.getAllProfanity(commentController.text);
      var dialog = CustomAlertDialog(
          title: 'Do you continue submitting?',
          message:
              'The following words will be censored:\n${wordsFound.join(", ")}',
          onFirstPressed: () {
            postIt = true;
            commentController.text = censorBadWords(commentController.text);
            Navigator.of(context, rootNavigator: true).pop();
          },
          onSecondPressed: () {
            postIt = false;
            //Navigator.of(context).pop();
            commentController.clear();
          },
          firstText: 'Yes',
          secondText: 'No');
      await showDialog(
          context: context, builder: (BuildContext context) => dialog);
    }

    if (postIt) {
      var doc = commentsRef.doc(postid).collection('comments').doc();

      await commentsRef.doc(postid).set({'postid': postid});

      await commentsRef.doc(postid).collection('comments').doc(doc.id).set({
        'comment': commentController.text,
        'time': DateTime.now(),
        'uid': uid,
        'username': username,
        'postid': postid,
        'commentid': doc.id,
        'color_code': color_code,
        'displayName': displayName,
        'picturepath': picturepath,
      });
      await db
          .collection('userData')
          .doc(uid)
          .collection('comment_history')
          .doc(doc.id)
          .set({
        'comment': commentController.text,
        'time': DateTime.now(),
        'uid': uid,
        'username': username,
        'postid': postid,
        'commentid': doc.id,
        'color_code': color_code,
        'displayName': displayName,
        'picturepath': picturepath,
      });
      replying = false;
      replyTo = '';

      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: buildComments()),
          Divider(),
          ListTile(
            title: TextFormField(
              focusNode: focusNode,
              controller: commentController,
              decoration: InputDecoration(labelText: 'Write a comment...'),
            ),
            trailing: OutlinedButton(
              onPressed: () async {
                addComment();
                var uid = await Provider.of(context).auth.getCurrentUID();
                await db
                    .collection('userData')
                    .doc(uid)
                    .update({'points_field': FieldValue.increment(5)});

                db.collection('userData').doc(uid);
              },
              child: Text('Post'),
            ),
          ),
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  Comment(
      {this.username,
      this.uid,
      this.comment,
      this.time,
      this.postid,
      this.commentid,
      this.color_code,
      this.displayName,
      this.picturepath});
  final String username;
  final String uid;
  final String comment;
  final DateTime time;
  final String postid;
  final String commentid;
  final int color_code;
  final String displayName;
  final String picturepath;

  // ignore: sort_constructors_first
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      uid: doc['uid'],
      comment: doc['comment'],
      time: doc['time'].toDate(),
      postid: doc['postid'],
      commentid: doc['commentid'],
      color_code: doc['color_code'],
      displayName: doc['displayName'],
      picturepath: doc['picturepath'],
    );
  }

  @override
  Widget build(BuildContext context) {
   Widget circleAvatarChild;
    if (picturepath != '\"\"') {
      circleAvatarChild = Container();
    } else {
      circleAvatarChild = Text(displayName[0].toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white));
    }
    return Column(
      children: <Widget>[
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            Visibility(
              visible: FirebaseAuth.instance.currentUser.uid == uid,
              child: 
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete_outline,
                onTap: () async {
                  var dialog = CustomAlertDialog(
                      title: 'Are you sure you want to delete this comment?',
                      message: 'There is no way to undo this.',
                      onFirstPressed: () async {
                        Navigator.of(context).pop();
                        //db stuff
                        await db
                            .collection('userData')
                            .doc(uid)
                            .collection('comment_history')
                            .doc(commentid)
                            .delete();
                        await db
                            .collection('comments')
                            .doc(postid)
                            .collection('comments')
                            .doc(commentid)
                            .delete();
                      },
                      firstText: 'Yes',
                      secondText: 'No');
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) => dialog);
                },
              ),
            ),
            IconSlideAction(
              color: Colors.grey[700],
              icon: Icons.reply_outlined,
              onTap: () {
                replying = !replying;
                replyTo = username;
                if (replying) {
                  commentController.text =
                      'Replying to ' + replyTo + ': ' + commentController.text;
                  FocusScope.of(context).requestFocus(focusNode);
                } else {
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ],
          child: Container(
            color: Colors.white,
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Row(
                children: <Widget>[
                  UserName(postid: '', uid: uid, username: username),
                ],
              ),
              leading:  CircleAvatar(
                            backgroundImage: /*user['profilepicture'] == "\"\""
                                ? AssetImage('assets/empty-profile.png')
                                : */FileImage(File(picturepath)),
                            backgroundColor:
                                Color(color_code).withOpacity(1.0),
                            child:
                                circleAvatarChild),
              subtitle: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 20,
                      child: Text('\n$comment\n',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(DateFormat('MM/dd/yyyy (h:mm a)')
                          .format(time)
                          .toString()),
                    ]),
              ]),
              isThreeLine: true,
            ),
          ),
        ),
        Divider(),
      ],
    );
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
