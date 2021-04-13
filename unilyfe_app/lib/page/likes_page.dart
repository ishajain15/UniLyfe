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
  //

  getLikeData() async {
    current_uid = await Provider.of(context).auth.getCurrentUID();
  }

  Widget displayLikeButton(context, snapshot) {
    // print('in display like button');
    // ignore: unused_local_variable
    final authData = snapshot.data;
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: getLikeData(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // print('current_uid: ' + current_uid);
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
    /*print('current_uid: ' + current_uid);
    print('here!');
    var liked = map_liked[current_uid] == true;
    return IconButton(
      icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
          color: liked ? Colors.red : Colors.grey),
      onPressed: () => handleLikePost(),
    );*/
  }

  handleLikePost() async {
    current_uid = await Provider.of(context).auth.getCurrentUID();
    var isliked = map_liked[current_uid] == true;
    liked = map_liked[current_uid] == true;
    var doc = db.collection('liked_posts').doc();

    String postCollection = '';

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
        // likes -= 1;
        liked = false;
        map_liked[current_uid] = false;
      });
      print("UNLIKED!");
      print("post id: " + postid);

      //db.collection("cities").doc("DC").delete()
      await db
          .collection('userData')
          .doc(current_uid)
          .collection('liked_posts')
          .doc(postid)
          .delete();
      //.collection('liked_posts').where('postid', isEqualTo: postid)
      //.get();
      //.delete();

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

      print("LIKED!");

      Post post = Post(postid, title, time, text, postChannel, uid, likes,
          liked, map_liked, username, location, event_date, null, null);

      //Post post = Provider.of(context).db.collection('posts').doc(postid).get();
      /*String title = '';
       Post post = Post('', '', DateTime.now(), '', '', '', 0, true, Map());
       await db.collection('posts').doc(postid).get().then((result) {
         post.postid = result['postid'].toString();
         post.title = result['title'].toString();
         post.time = result['time'];
         post.text = result['text'].toString();
         post.postChannel = result['postChannel'].toString();
         post.uid = result['uid'].toString();
         post.likes = result['likes'];
         post.liked = result['liked'];
         post.map_liked = result['map_liked'];
         title = result['title'].toString();
       });*/

      /* 'postid': postid,
        'postType': 0,
        'title': title,
        'time': time,
        'text': text,
        'postChannel': postChannel,
        'uid': uid,
        'likes': likes,
        'liked': liked,
        'map_liked':map_liked */

      await db
          .collection('userData')
          .doc(current_uid)
          .collection('liked_posts')
          //.doc(doc.id)
          .doc(postid)
          .set(post.toJson());
      //.set({'title' : title});
      //.set(db.collection('posts').doc(postid));
    }
  }

  @override
  FutureBuilder build(BuildContext context) {
    //current_uid = await Provider.of(context).auth.getCurrentUID();
    /*var liked = map_liked[current_uid] == true;
    liked ? print('this post is liked!') : print('this post is not liked!');
    return IconButton(
      icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
          color: liked ? Colors.red : Colors.grey),
      onPressed: () => handleLikePost(),
    );*/
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
