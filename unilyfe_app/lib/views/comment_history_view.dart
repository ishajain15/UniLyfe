import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/page/comments_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:intl/intl.dart';

class CommentHistoryView extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'COMMENT HISTORY',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),*/
      body: Column(
        children: <Widget>[
          Expanded(
            child: Flexible(
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
        .collection('userData')
        .doc(uid)
        .collection('comment_history')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Widget buildPostCard(BuildContext context, DocumentSnapshot comment) {
    return Column(children: <Widget>[
      ListTile(
        dense: true,
        title: Text(comment['comment'] + '\n'),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          backgroundImage: AssetImage('assets/empty-profile.png'),
        ),
        subtitle: Text(DateFormat('MM/dd/yyyy (h:mm a)')
            .format(comment['time'].toDate())
            .toString()),
      ),
      Divider(),
    ]);
  }
}
