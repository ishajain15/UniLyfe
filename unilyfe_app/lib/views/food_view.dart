import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_food.dart';
import 'package:unilyfe_app/views/home_view.dart';
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
                  if (!snapshot.hasData) return const Text('Loading...');
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
        .collection('food_posts')
        .orderBy('time', descending: true)
        .snapshots();
    // .collection("userData")
    // .doc(uid)
    // .collection("posts")
    // .snapshots();
  }
}
