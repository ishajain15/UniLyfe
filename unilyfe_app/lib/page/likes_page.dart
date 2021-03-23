import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
// ignore: must_be_immutable
class Likes extends StatefulWidget{
  Likes({Key key, @required this.postid, @required this.likes, @required this.liked, @required this.postChannel, @required this.map_liked, @required this.uid})
      : super(key: key);
  String postid;
  int likes;
  bool liked;
  String postChannel;
  dynamic map_liked; 
  String uid;
  @override
  LikeState createState()=> LikeState(postid: postid, likes:likes, liked:liked, postChannel: postChannel,map_liked: map_liked, uid:uid);
}

class LikeState extends State<Likes>{
  LikeState({Key key, @required this.postid, @required this.likes, @required this.liked, @required this.postChannel, @required this.map_liked, @required this.uid});
 
  int likes;
  String postid;
  bool liked;
  String postChannel;
  dynamic map_liked; 
  String uid;
  // ignore: always_declare_return_types
  _pressed(){
  // ignore: unused_local_variable
  final db = FirebaseFirestore.instance;
  setState(() {
    if(postChannel == 'FOOD'){
      postChannel = 'food_posts';
    }else if(postChannel == 'STUDY'){
      postChannel = 'study_posts';
    } else{
      postChannel = 'social_posts';
    }
    liked = !liked;
    if(liked){
      likes += 1;
      // liked = true;
      Provider.of(context).db.collection('posts').doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'map_liked.$uid': liked});
      Provider.of(context).db.collection('posts').doc(postid).update({'map_liked.$uid': liked});
    }else{
      likes -= 1;
      // liked = false;
      Provider.of(context).db.collection('posts').doc(postid).update({'likes': likes});
      Provider.of(context).db.collection('posts').doc(postid).update({'map_liked.$uid': liked});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'map_liked.$uid': liked});
    }
  });
}
      @override
  Widget build(BuildContext context){
        return IconButton(
          icon: Icon(liked ? Icons.favorite: Icons.favorite_border, 
                      color: liked ? Colors.red : Colors.grey),
          onPressed: () => _pressed(),
        );
      }
}
