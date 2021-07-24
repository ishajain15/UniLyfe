import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/customized_items/buttons/information_button_study.dart';
import 'package:unilyfe_app/views/home_view.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';

class StudyViewState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StudyView();
}

class StudyView extends State<StudyViewState> {
  bool hasBeenPressed = false;

  @override
  Widget build(BuildContext context) {
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
              InformationButtonStudy(),
              Spacer(),
            ],
          ),
          Flexible(
            child: StreamBuilder(
                stream: getUserPostsStreamSnapshots(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return buildLoading();
                  } 
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

    // the user clicked the "randomized" button
    if (hasBeenPressed == true) {
      yield* FirebaseFirestore.instance.collection('study_posts').snapshots();
    } else {
      yield* FirebaseFirestore.instance
          .collection('study_posts')
          .orderBy('time', descending: true)
          .snapshots();
    }

    // the user clicked the "revert" button
    if (hasBeenPressed == false) {
      yield* FirebaseFirestore.instance
          .collection('study_posts')
          .orderBy('time', descending: true)
          .snapshots();
    }

    // .collection("userData")
    // .doc(uid)
    // .collection("posts")
    // .snapshots();
  }

  // Randomizing Posts
  dynamic onPressed() {
    setState(() {
      hasBeenPressed = !hasBeenPressed;
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
  dynamic onPressed_2() {
    setState(() {
      hasBeenPressed = !hasBeenPressed;
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
}

// Widget buildLoading() => Center(
//         child: ColorLoader4(
//       dotOneColor: Color(0xFFF46C6B),
//       dotTwoColor: Color(0xFFF47C54),
//       dotThreeColor: Color(0xFFFCAC54),
//       dotType: DotType.square,
//       duration: Duration(milliseconds: 1200),
//     ));
