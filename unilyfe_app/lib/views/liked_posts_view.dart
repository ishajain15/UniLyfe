import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/views/home_view.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class LikedPostsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          Flexible(
            child: StreamBuilder(
                stream: getUserPostsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return buildLoading();
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          HomeView().buildPostCard(
                              context, snapshot.data.docs[index]));
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
        .collection('userData')
        .doc(uid)
        .collection('liked_posts')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
