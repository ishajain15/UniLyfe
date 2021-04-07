import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:unilyfe_app/customized_items/custom_warning.dart';
import 'package:unilyfe_app/customized_items/loaders/color_loader_4.dart';
import 'package:unilyfe_app/customized_items/loaders/dot_type.dart';
import 'package:unilyfe_app/page/tabs/username_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

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
  CommentsPage({this.postid, this.uid, this.username});
  final String postid;
  final String uid;
  final String username;
  @override
  CommentsPageState createState() => CommentsPageState(
        postid: postid,
        uid: uid,
        username: username,
      );
}

class CommentsPageState extends State<CommentsPage> {
  CommentsPageState({this.postid, this.uid, this.username});

  final String postid;
  final String uid;
  final String username;

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
      wordsFound.forEach((element) {
        print(element);
      });
    }

    if (postIt) {
      var doc = commentsRef.doc(postid).collection('comments').doc();

      await commentsRef.doc(postid).set({'postid': postid});

      await commentsRef.doc(postid).collection('comments').doc(doc.id).set({
        'comment': commentController.text,
        'time': DateTime.now(),
        'uid': uid,
        'username': username,
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
  Comment({this.username, this.uid, this.comment, this.time});
  final String username;
  final String uid;
  final String comment;
  final DateTime time;

  // ignore: sort_constructors_first
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      uid: doc['uid'],
      comment: doc['comment'],
      time: doc['time'].toDate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Row(
            children: <Widget>[
              UserName(postid: '', uid: uid, username: username),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            //radius: 18,
            backgroundImage: AssetImage('assets/empty-profile.png'),
          ),
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
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(DateFormat('MM/dd/yyyy (h:mm a)').format(time).toString()),
            ]),
          ]),
          trailing: OutlinedButton(
            onPressed: () {
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
            style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
            child: Text('Reply',
                style: TextStyle(fontSize: 16, color: Color(0xFFF46C6B))),
          ),
          isThreeLine: true,
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
