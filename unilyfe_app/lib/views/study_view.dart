import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_study.dart';
import 'package:unilyfe_app/customized_items/buttons/randomize_page.dart';
import 'package:unilyfe_app/customized_items/buttons/revert.dart';
import 'package:unilyfe_app/views/home_view.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class StudyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InformationButtonStudy(),
          //RandomizePage(),
          //RevertPage(),
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
          .collection('study_posts')
          .orderBy('time', descending: true)
          .snapshots();
      // if (RandomizePage().randomizing_criteria() == true) {
      //     print('randomize SHOULDVE been clicked!');
      //     yield* FirebaseFirestore.instance
      //       .collection('posts')
      //       .snapshots();
      // }
      // if (RevertPage().revert_criteria() == true) {
      //     print('revert SHOULDVE been clicked');
      //   yield* FirebaseFirestore.instance
      //     .collection('posts')
      //     .orderBy('time', descending: true)
      //     .snapshots();
      // }
      
      // .collection("userData")
      // .doc(uid)
      // .collection("posts")
      // .snapshots();
  }
}
