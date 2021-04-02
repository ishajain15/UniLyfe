class Post {
  Post(this.postid, this.title, this.time, this.text, this.postChannel,
      this.uid, this.likes, this.liked, this.map_liked, this.username);
  String postid;
  int postType;
  String title;
  DateTime time;
  String text;
  String postChannel;
  String uid;
  String username;
  int likes;
  bool liked;
  Map<String, dynamic> map_liked;
  Map<String, dynamic> toJson() => {
        'postid': postid,
        'postType': 0,
        'title': title,
        'time': time,
        'text': text,
        'postChannel': postChannel,
        'uid': uid,
        'likes': likes,
        'liked': liked,
        'map_liked': map_liked,
        'username': username,
      };
}
