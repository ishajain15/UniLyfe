import 'package:flutter/material.dart';
import 'package:unilyfe_app/customized_items/loaders/color_loader_4.dart';
import 'package:unilyfe_app/customized_items/loaders/dot_type.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/models/post.dart';

// ignore: must_be_immutable
bool liked;

// ignore: must_be_immutable
class Likes extends StatefulWidget {
  Likes({
    Key key,
    @required this.postid,
    @required this.title,
    @required this.time,
    @required this.text,
    @required this.likes,
    @required this.liked,
    @required this.postChannel,
    @required this.map_liked,
    @required this.uid,
    @required this.username,
    @required this.location, 
    @required this.event_date
  }) : super(key: key);
  String postid;
  String title;
  DateTime time;
  String text;
  int likes;
  bool liked;
  String postChannel;
  dynamic map_liked;
  String uid;
  String username;
  String location;
  DateTime event_date;
  @override
  LikeState createState() => LikeState(
        postid: postid,
        title: title,
        time: time,
        text: text,
        likes: likes,
        liked: liked,
        postChannel: postChannel,
        map_liked: map_liked,
        uid: uid,
        username: username,
        location: location,
        event_date: event_date,
      );
}

class LikeState extends State<Likes> {
  LikeState({
    Key key,
    @required this.postid,
    @required this.title,
    @required this.time,
    @required this.text,
    @required this.likes,
    @required this.liked,
    @required this.postChannel,
    @required this.map_liked,
    @required this.uid,
    @required this.username,
    @required this.location,
    @required this.event_date
  }); /*({Key key, @required this.postid, @required this.likes, @required this.postChannel, @required this.map_liked, @required this.uid});*/
  String postid;
  String title;
  DateTime time;
  String text;
  int likes;
  bool liked;
  String postChannel;
  dynamic map_liked;
  String uid;
  String current_uid;
  String username;
  String location;
  DateTime event_date;
  final db = FirebaseFirestore.instance;
  // ignore: always_declare_return_types

  dynamic getLikeData() async {
    current_uid = await Provider.of(context).auth.getCurrentUID();
  }

  Widget displayLikeButton(context, snapshot) {
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: getLikeData(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var liked = map_liked[current_uid] == true;
                return IconButton(
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      color: liked ? Colors.red : Colors.grey[500],
                    ),
                    onPressed: () => handleLikePost());
              }
              return Container();
            }),
      ],
    );
  }

  dynamic handleLikePost() async {
    current_uid = await Provider.of(context).auth.getCurrentUID();
    var isliked = map_liked[current_uid] == true;
    liked = map_liked[current_uid] == true;

    var postCollection = '';

    if (postChannel == 'FOOD') {
      postCollection = 'food_posts';
    } else if (postChannel == 'STUDY') {
      postCollection = 'study_posts';
    } else {
      postCollection = 'social_posts';
    }
    if (isliked) {
      likes -= 1;
      Provider.of(context)
          .db
          .collection(postCollection)
          .doc(postid)
          .update({'likes': likes});
      Provider.of(context)
          .db
          .collection(postCollection)
          .doc(postid)
          .update({'map_liked.$current_uid': false});
      Provider.of(context)
          .db
          .collection('posts')
          .doc(postid)
          .update({'likes': likes});
      Provider.of(context)
          .db
          .collection('posts')
          .doc(postid)
          .update({'map_liked.$current_uid': false});
      setState(() {
        liked = false;
        map_liked[current_uid] = false;
      });

      await db
          .collection('userData')
          .doc(current_uid)
          .collection('liked_posts')
          .doc(postid)
          .delete();

    } else if (!isliked) {
      likes += 1;
      Provider.of(context)
          .db
          .collection(postCollection)
          .doc(postid)
          .update({'likes': likes});
      Provider.of(context)
          .db
          .collection(postCollection)
          .doc(postid)
          .update({'map_liked.$current_uid': true});
      Provider.of(context)
          .db
          .collection('posts')
          .doc(postid)
          .update({'likes': likes});
      Provider.of(context)
          .db
          .collection('posts')
          .doc(postid)
          .update({'map_liked.$current_uid': true});
      setState(() {
        // likes += 1;
        liked = true;
        map_liked[current_uid] = true;
      });

      var post = Post(postid, title, time, text, postChannel, uid, likes,
          liked, map_liked, username, location, event_date, null, null, null);

      await db
          .collection('userData')
          .doc(current_uid)
          .collection('liked_posts')
          .doc(postid)
          .set(post.toJson());
    }
  }

  @override
  FutureBuilder build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of(context).auth.getCurrentUID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return displayLikeButton(context, snapshot);
        } else {
          return buildLoading();
        }
      },
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
