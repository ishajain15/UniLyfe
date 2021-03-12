class Post {
  String title;
  DateTime time;
  String text;
  String postChannel;
  String uid;

  Post(this.title, this.time, this.text, this.postChannel, this.uid);

  Map<String, dynamic> toJson() => {
        'title': title,
        'time': time,
        'text': text,
        'postChannel': postChannel,
        'uid': uid,
      };
}
