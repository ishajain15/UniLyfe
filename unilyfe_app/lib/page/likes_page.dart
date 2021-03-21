import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
class Likes extends StatefulWidget{
  String postid;
  int likes;
  bool liked;
  String postChannel;
 Likes({Key key, @required this.postid, @required this.likes, @required this.liked, @required this.postChannel})
      : super(key: key);  
  @override
  LikeState createState()=> new LikeState(postid: postid, likes:likes, liked:liked, postChannel: postChannel);
}

class LikeState extends State<Likes>{
  int likes;
  String postid;
  bool liked;
  String postChannel;
 LikeState({Key key, @required this.postid, @required this.likes, @required this.liked, @required this.postChannel});
  @override
  _pressed(){
  final db = FirebaseFirestore.instance;
  setState(() {
    if(postChannel == "FOOD"){
      postChannel = 'food_posts';
    }else if(postChannel == "STUDY"){
      postChannel = 'study_posts';
    } else{
      postChannel = 'social_posts';
    }
    liked = !liked;
    if(liked){
      likes += 1;
      liked = true;
      Provider.of(context).db.collection('posts').doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'liked': liked});
      Provider.of(context).db.collection('posts').doc(postid).update({'liked': liked});
    }else{
      likes -= 1;
      liked = false;
      Provider.of(context).db.collection('posts').doc(postid).update({'likes': likes});
      Provider.of(context).db.collection('posts').doc(postid).update({'liked': liked});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'liked': liked});
    }
  });
}
      Widget build(BuildContext context){
        return IconButton(
          icon: Icon(liked ? Icons.favorite: Icons.favorite_border, 
                      color: liked ? Colors.red : Colors.grey),
          onPressed: () => _pressed(),
        );
      }
}
