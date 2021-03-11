import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: getUserPostsStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildPostCard(context, snapshot.data.docs[index]));
          }),
    );
  }

  Stream<QuerySnapshot> getUserPostsStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection("posts").snapshots();
    // .collection("userData")
    // .doc(uid)
    // .collection("posts")
    // .snapshots();
  }

  Widget buildPostCard(BuildContext context, DocumentSnapshot post) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      post['title'],
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 40.0),
                child: Row(
                  children: <Widget>[
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(post['time'].toDate()).toString()}"),
                    Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("${(post['text'] == null) ? "n/a" : post['text']}"),
                    Spacer(),
                    //Text(post['postType']),
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
