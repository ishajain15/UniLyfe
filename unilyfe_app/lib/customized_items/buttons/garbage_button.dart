import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/custom_warning.dart';

class GarbageButtonWidget extends StatelessWidget {
  GarbageButtonWidget(
      {Key key,
      @required this.postid,
      this.uid,
      this.username,
      @required this.postChannel})
      : super(key: key);

  final String postid;
  final String uid;
  final String username;
  final String postChannel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: IconButton(
        icon: Icon(
          Icons.delete_outline_outlined,
          size: 25.0,
          color: Colors.grey,
        ),
        onPressed: () async {
          var dialog = CustomAlertDialog(
              title: 'Are you sure you want to delete this post?',
              message: 'There is no way to undo this.',
              onFirstPressed: () async {
                Navigator.of(context).pop();
                var postCollection = '';

                if (postChannel == 'FOOD') {
                  postCollection = 'food_posts';
                } else if (postChannel == 'STUDY') {
                  postCollection = 'study_posts';
                } else {
                  postCollection = 'social_posts';
                }

                final db = FirebaseFirestore.instance;
                await db.collection('posts').doc(postid).delete();
                await db
                    .collection('comments')
                    .where('postid', isEqualTo: postid)
                    .get()
                    .then((querySnapshot) {
                  querySnapshot.docs.forEach((result) {
                    db
                        .collection('comments')
                        .doc(result.id)
                        .collection('comments')
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((result) {
                        result.reference.delete();
                      });
                    });
                  });
                });
                await db
                    .collection('comments')
                    .doc(postid)
                    .delete();

                // Get data from docs and convert map to List
                await db.collection(postCollection).doc(postid).delete();
                await db.collection('userData').get().then((querySnapshot) {
                  querySnapshot.docs.forEach((result) {
                    db
                        .collection('userData')
                        .doc(result.id)
                        .collection('liked_posts')
                        .where('postid', isEqualTo: postid)
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((result) {
                        result.reference.delete();
                      });
                    });
                  });
                });
                await db.collection('userData').get().then((querySnapshot) {
                  querySnapshot.docs.forEach((result) {
                    db
                        .collection('userData')
                        .doc(result.id)
                        .collection('comment_history')
                        .where('postid', isEqualTo: postid)
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((result) {
                        result.reference.delete();
                      });
                    });
                  });
                });
              },
              firstText: 'Yes',
              secondText: 'No');
          await showDialog(
              context: context, builder: (BuildContext context) => dialog);
        },
      ),
    );
  }
}
