class PollPost {
  PollPost(this.postid, this.title, this.time, this.text, this.postChannel,
      this.uid, this.likes, this.liked, this.map_liked, this.username, this.location, this.event_date, this.options, this.users);

  String postid;
  int postType;
  String title;
  DateTime time;
  String text;
  String postChannel;
  String uid;
  int likes;
  bool liked;
  Map<String, dynamic> map_liked;
  String username;
  String location;
  DateTime event_date;
  dynamic options;
  Map<String, dynamic> users;
  Map<String, dynamic> toJson() => {
        'postType': 1,
        'title': title,
        'time': time,
        'text': text,
        'postChannel': postChannel,
        'uid': uid,
        'likes': likes,
        'liked': liked,
        'postid': postid,
        'map_liked': map_liked,
        'username': username,
        'location': location,
        'event_date': event_date,
        'options':options,
        'users':users
      };
}
