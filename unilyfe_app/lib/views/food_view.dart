import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_food.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class FoodView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //InformationButtonFood(),
      //InformationButtonStudy(),
      //InformationButtonSocial(),

      child: Column(
        children: [
          InformationButtonFood(),
          Flexible(
            child: StreamBuilder(
                stream: getUserPostsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text("Loading...");
                  return new ListView.builder(
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
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection("food_posts").orderBy('time', descending: true).snapshots();
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
                    Expanded(
                      flex: 15,
                      child: Text(
                        "Title: ${(post['title'] == null) ? "n/a" : post['title']}",
                        style: TextStyle(fontSize: 20),
                      ),
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
