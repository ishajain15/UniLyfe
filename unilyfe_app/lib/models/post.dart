class Post {
  String title;
  DateTime time;
  String text;
  String postType;
  String uid;

  Post(this.title, this.time, this.text, this.postType, this.uid);

  Map<String, dynamic> toJson() => {
        'title': title,
        'time': time,
        'text': text,
        'postType': postType,
        'uid': uid,
      };
}
