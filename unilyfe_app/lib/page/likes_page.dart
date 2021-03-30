
import 'package:flutter/material.dart';
import 'package:unilyfe_app/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: must_be_immutable
bool liked;
// ignore: must_be_immutable
class Likes extends StatefulWidget{
  Likes({Key key, @required this.postid, @required this.likes, @required this.postChannel, @required this.map_liked, @required this.uid})
      : super(key: key);
  String postid;
  int likes;
  String postChannel;
  dynamic map_liked; 
  String uid;
  @override
  LikeState createState()=> LikeState(postid: postid, likes:likes, postChannel: postChannel,map_liked: map_liked, uid:uid);
}

class LikeState extends State<Likes>{
  LikeState({Key key, @required this.postid, @required this.likes, @required this.postChannel, @required this.map_liked, @required this.uid});
  int likes;
  String postid;
  String postChannel;
  dynamic map_liked; 
  String uid;
  String current_uid;
  final db = FirebaseFirestore.instance;
  // ignore: always_declare_return_types
  handleLikePost() async{
  current_uid = await Provider.of(context).auth.getCurrentUID();
  var isliked = map_liked[current_uid] == true;
  liked = map_liked[current_uid] == true;
  var doc = db.collection('liked_posts').doc();

    if(postChannel == 'FOOD'){
      postChannel = 'food_posts';
    }else if(postChannel == 'STUDY'){
      postChannel = 'study_posts';
    } else{
      postChannel = 'social_posts';
    }
    if(isliked){
      likes-=1;
      Provider.of(context).db.collection(postChannel).doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'map_liked.$current_uid': false});
      Provider.of(context).db.collection('posts').doc(postid).update({'likes': likes});
      Provider.of(context).db.collection('posts').doc(postid).update({'map_liked.$current_uid': false});
      setState(() {
        // likes -= 1; 
        liked = false;
        map_liked[current_uid] = false;
      });
    }else if (!isliked){
      likes+=1;
      Provider.of(context).db.collection(postChannel).doc(postid).update({'likes': likes});
      Provider.of(context).db.collection(postChannel).doc(postid).update({'map_liked.$current_uid': true});
      Provider.of(context).db.collection('posts').doc(postid).update({'likes': likes});
      Provider.of(context).db.collection('posts').doc(postid).update({'map_liked.$current_uid': true});
      setState(() {
        // likes += 1; 
        liked = true;
        map_liked[current_uid] = true;
      }); 

      print("here in the liked thingy!");
       await db
        .collection('userData')
        .doc(uid)
        .collection('liked_posts')
        .doc(doc.id)
        .set(db.collection('posts').doc(postid));
    }
  }
      @override
  Widget build(BuildContext context){
  var liked = map_liked[current_uid] == true;
        return IconButton(
          icon: Icon(liked ? Icons.favorite: Icons.favorite_border, 
                      color: liked ? Colors.red : Colors.grey),
          onPressed: () => handleLikePost(),
        );
      }
}
