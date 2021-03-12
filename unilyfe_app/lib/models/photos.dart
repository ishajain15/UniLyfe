class Photo {
  String caption;
  DateTime time;
  String image;
  String uid;

  Photo(this.caption, this.time, this.image, this.uid);

  Map<String, dynamic> toJson() => {
        'caption': caption,
        'time': time,
        'image': image,
        'uid': uid,
      };
}