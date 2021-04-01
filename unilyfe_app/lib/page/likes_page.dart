import 'package:flutter/material.dart';
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
  final db = FirebaseFirestore.instance;
  // ignore: always_declare_return_types
  //

  getLikeData() async {
    current_uid = await Provider.of(context).auth.getCurrentUID();
  }

  Widget displayLikeButton(context, snapshot) {
    print('in display like button');
    // ignore: unused_local_variable
    final authData = snapshot.data;
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: getLikeData(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print('current_uid: ' + current_uid);
                var liked = map_liked[current_uid] == true;
                return IconButton(
                    icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
                        color: liked ? Colors.red : Colors.grey),
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

    if (postChannel == 'FOOD') {
      postChannel = 'food_posts';
    } else if (postChannel == 'STUDY') {
      postChannel = 'study_posts';
    } else {
      postChannel = 'social_posts';
    }
    if (isliked) {
      likes -= 1;
      Provider.of(context)
          .db
          .collection(postChannel)
          .doc(postid)
          .update({'likes': likes});
      Provider.of(context)
          .db
          .collection(postChannel)
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
          .collection(postChannel)
          .doc(postid)
          .update({'likes': likes});
      Provider.of(context)
          .db
          .collection(postChannel)
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

      Post post = Post(
          postid, title, time, text, postChannel, uid, likes, liked, map_liked);

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
          return CircularProgressIndicator();
        }
      },
    );
  }
}
