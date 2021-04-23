import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:unilyfe_app/page/tabs/username_page.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:intl/intl.dart';

class ReviewViewState extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }

  Stream<QuerySnapshot> getUserPostsStreamSnapshots(
      BuildContext context) async* {
    // ignore: unused_local_variable
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('reviews')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Widget buildPostCard(BuildContext context, DocumentSnapshot review) {
    return 
    // Column(children: <Widget>[
    //   ListTile(
    //     dense: true,
    //     title: Text(comment['title'] + '\n'),
    //     subtitle: Text(DateFormat('MM/dd/yyyy (h:mm a)')
    //         .format(comment['time'].toDate())
    //         .toString()),
    //   ),
    //   Divider(),
    // ]);
    Container(
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
                          postid: '',
                          uid: review['uid'],
                          username: review['username'])
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
                          "Title: ${(review['title'] == null) ? "n/a" : review['title']}",
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
                          "Date posted: ${DateFormat('MM/dd/yyyy (h:mm a)').format(review['time'].toDate()).toString()}"),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "Location: ${review['location']}"),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: SmoothStarRating(
                          rating: review['rating'],
                          isReadOnly: true,
                          allowHalfRating: true,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                        )),
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
                            "Text: ${(review['text'] == null) ? "n/a" : review['text']}"),
                      ),
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
