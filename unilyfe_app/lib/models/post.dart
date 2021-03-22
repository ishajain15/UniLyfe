class Post {
  Post(this.postid, this.title, this.time, this.text, this.postChannel,
      this.uid, this.likes, this.liked);
  String postid;
  int postType;
  String title;
  DateTime time;
  String text;
  String postChannel;
  String uid;
  int likes;
  bool liked;

  Map<String, dynamic> toJson() => {
        'postid': postid,
        'postType': 0,
        'title': title,
        'time': time,
        'text': text,
        'postChannel': postChannel,
        'uid': uid,
        'likes': likes,
        'liked': liked
      };
}
